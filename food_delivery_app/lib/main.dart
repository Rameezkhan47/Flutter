import 'package:flutter/material.dart';
import 'package:food_delivery_app/dummy/sample_data.dart';
import 'package:food_delivery_app/screens/category_meals_screen.dart';
import './screens/tabs_screen.dart';
import 'screens/categories_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/filters_screen.dart';
import './screens/favorites_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List _availableMeals = DUMMY_MEALS;
  final List _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String id) {
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == id);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == id));
      });
    }
  }

  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
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
            titleLarge: TextStyle(
                fontSize: 24.0,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w400),
            bodyMedium: TextStyle(
                fontSize: 13.0,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w800),
            bodySmall: TextStyle(
                fontSize: 12.0, color: Color.fromARGB(255, 114, 114, 114)),
          ),
        ),
        // home:  const CategoriesScreen(),
        initialRoute: '/', //default route is by convention '/'
        routes: {
          CategoryMealsScreen.routeName: (ctx) =>
              CategoryMealsScreen(_availableMeals),
          MealDetailScreen.routeName: (ctx) =>  MealDetailScreen(_toggleFavorite, _isMealFavorite),
          FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilters),
          FavoritesScreen.routeName:(ctx) => FavoritesScreen(_favoriteMeals),
        },
        // onGenerateRoute: (settings) {
        //   // print(settings.arguments);
        //   // if (settings.name == '/meal-detail') {
        //   //   return ...;
        //   // } else if (settings.name == '/something-else') {
        //   //   return ...;
        //   // }
        //   // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
        // },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (ctx) => const CategoriesScreen(),
          );
        },
      ),
    );
  }
}
