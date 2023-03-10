import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final String image;
  final String description;

  const CategoryItem(
      this.id, this.title, this.description, this.color, this.image,
      {super.key});

  void selectCategory(BuildContext ctx) { 
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName, arguments: { //convenient for multiple page routes, allows us to send args with route name so no need for prop drilling
      'id': id,
      'title': title,

    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).colorScheme.background,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                    width: 20), // Add some spacing between text and image
              ],
            ),
            Positioned(
                top: 20,
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall,
                )),
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                width: 50,
                child: Image.asset(
                  image,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
