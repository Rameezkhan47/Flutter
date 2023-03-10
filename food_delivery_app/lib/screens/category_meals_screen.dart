import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/menu_item.dart';
import '../dummy/dummy_data.dart';
import '';



class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meal';
  const CategoryMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>; //extract args from route
final categoryTitle = routeArgs['title'];
final categoryId = routeArgs['id'];
final categoryMeals = DUMMY_MEALS.where((element) {return
  element.categories.contains(categoryId);
},).toList();
    return   Scaffold(
      appBar: AppBar(title:  Text(categoryTitle!)),
      body: ListView.builder(itemBuilder: (ctx, index){
        return MealItem(title: categoryMeals[index].title, imageUrl: categoryMeals[index].imageUrl, affordability: categoryMeals[index].affordability, complexity: categoryMeals[index].complexity, duration: categoryMeals[index].duration);
      }, itemCount: categoryMeals.length
      ),
    );
  }
}