import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import './categories_screen.dart';
import '../widgets/main_drawer.dart';



class FavoritesScreen extends StatelessWidget {
  final List favoriteMeals;
    static const routeName = '/favorites';

   const FavoritesScreen(this.favoriteMeals,{super.key});

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = AppBar(
  title: const Text('favorites'),
  actions: 
       [
          IconButton(
            icon: const Icon(
              Icons.home_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
);
    if(favoriteMeals.isEmpty) {
      return Scaffold(
        appBar: appBar,
        body: const Center(
        child: Text('You have no favorites yet - start adding some!'),
      ),
      ) ;
    }
    return Scaffold(
      appBar: appBar,
      body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
                id: favoriteMeals[index].id,
                title: favoriteMeals[index].title,
                imageUrl: favoriteMeals[index].imageUrl,
                affordability: favoriteMeals[index].affordability,
                complexity: favoriteMeals[index].complexity,
                duration: favoriteMeals[index].duration);
          },
          itemCount: favoriteMeals.length),
          drawer: const MainDrawer(),

    );

    
  }
}