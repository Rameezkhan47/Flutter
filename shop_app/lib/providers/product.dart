import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  ///mixin with ChangeNotifier that gives us access to nethod notifyListeners()
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String id) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://flutter-41360-default-rtdb.firebaseio.com/products/$id.json';
    try {
      final response = await http.patch(
        Uri.parse(url),
        body: json.encode({'isFavorite': isFavorite}),
      );
      if (response.statusCode >= 400) {
        print('old status');
        _setFavValue(oldStatus);
      }
      print('all ok');
    } catch (e) {
      print('error');
      _setFavValue(oldStatus);
    }
  }
}
