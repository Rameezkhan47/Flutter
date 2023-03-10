import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final String description;
  final Color color;
  final String? image;

  const Category({
    required this.id,
    required this.title,
    required this.description,
    this.color = Colors.orange,
    this.image
  });
}
