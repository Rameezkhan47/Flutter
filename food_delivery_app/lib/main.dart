import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/category_meals_screen.dart';

import 'screens/categories_screen.dart';
import './screens/meal_detail_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: MaterialApp(
        title: 'foodpanda',  
        theme: ThemeData(
          primarySwatch: Colors
              .pink, //sets the theme for the app, the widgets will inherit shades of primary swatch
          colorScheme: const ColorScheme(
            primary: Colors.pink,
            secondary: Colors.amberAccent,
            surface: Colors.white,
            background: Colors.grey,
            error: Colors.redAccent,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.black,
            onBackground: Colors.black,
            onError: Colors.white,
            brightness: Brightness.light,
          ),
        fontFamily: 'VAGRounded',
          textTheme: const TextTheme(
            titleMedium: TextStyle(
                fontSize: 16.0,
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'OpenSans'), // sets theme for different texts
            displayLarge: TextStyle(fontSize: 24.0, color: Colors.white),
            titleLarge: TextStyle(fontSize: 24.0, fontFamily: 'OpenSans', fontWeight: FontWeight.w400),
            bodyMedium: TextStyle(fontSize: 13.0, fontFamily: 'OpenSans', fontWeight: FontWeight.w800),
            bodySmall: TextStyle(
                fontSize: 12.0, color: Color.fromARGB(255, 114, 114, 114)),
          ),
        ),
        // home:  const CategoriesScreen(),
        initialRoute: '/', //default route is by convention '/'
        routes: {
          '/': (ctx)=> const CategoriesScreen(),
          CategoryMealsScreen.routeName: (ctx)=> const CategoryMealsScreen(),
          MealDetailScreen.routeName: (ctx) => const MealDetailScreen(),
        },
              onGenerateRoute: (settings) {
        print(settings.arguments);
        // if (settings.name == '/meal-detail') {
        //   return ...;
        // } else if (settings.name == '/something-else') {
        //   return ...;
        // }
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen(),);
      },
      ),
    );
  
  }
}
