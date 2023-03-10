import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meal';
  const CategoryMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>; //extract args from route

    return   Scaffold(
      appBar: AppBar(title:  Text(routeArgs['title']!),),
      body: const Center(
        child: Text('Resturants near you')
      ),
    );
  }
}