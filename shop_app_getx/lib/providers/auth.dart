import 'dart:convert';
import 'dart:async';

// import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends GetxController {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;
  


  bool get isAuth {
    return _token != null;
  }

  String? get userId {
    return _userId;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {

    var url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAU6UXA7FO-CIcPRyl7s6OoTtOvYCyqEfg';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseBody = json.decode(response.body);
      if (responseBody['error'] != null) {
        throw HttpException(responseBody['error']['message']);
      }
      _token = responseBody['idToken'];
      _userId = responseBody['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseBody['expiresIn'],
          ),
        ),
      );
      _autoLogout();
      update();
      final preferences = await SharedPreferences
          .getInstance(); //getInstance is a future which returns the shared preferences instance
      final userData = json.encode({ 
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate?.toIso8601String(),

      });
      preferences.setString('userData', userData); //storing user creds in a map on a user's device
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async{

    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')){ //if no userData then user is not authenticated
      return false;
    }
    final  extractedUserData = jsonDecode(prefs.getString('userData')!); //gets data from device
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']); //extracts the expiry date
    if (expiryDate.isBefore(DateTime.now())){ //checks if the token is expired
      return false;
    }

    _token =extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;

    update();
    _autoLogout();

    return true;

  }

  Future<void> logout() async{
    _token = null;
    _expiryDate = null;
    _userId = null;
    _authTimer = null;
    update();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

}


// https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]
// AIzaSyAU6UXA7FO-CIcPRyl7s6OoTtOvYCyqEfg
// https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]


