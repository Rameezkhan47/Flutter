import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

class Product  {
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
    required this.isFavorite,
  });

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    final url =
        'https://flutter-41360-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(
        Uri.parse(url),
        body: json.encode(isFavorite),
      );
      if (response.statusCode >= 400) {
        isFavorite = oldStatus;
      }
    } catch (e) {
      isFavorite = oldStatus;
    }
  }
}
