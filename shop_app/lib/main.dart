import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';

import './providers/products.dart';
import './providers/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
// the Products instance is passed down to all its descendant widgets,
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(), 
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],

      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: MaterialApp(
          title: 'Shop App',
          theme: ThemeData(
            primarySwatch: Colors
                .pink, //sets the theme for the app, the widgets will inherit shades of primary swatch
            colorScheme: const ColorScheme(
              primary: Color.fromARGB(255, 255, 123, 0),
              secondary: Colors.amberAccent,
              surface: Colors.white,
              background: Colors.grey,
              error: Colors.red,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              onSurface: Colors.black,
              onBackground: Colors.black,
              onError: Colors.white,
              brightness: Brightness.light,
            ),
            fontFamily: 'VAGRounded',
            textTheme: const TextTheme(
              titleMedium: TextStyle(fontSize: 16.0, fontFamily: 'Quicksand'),
              titleSmall: TextStyle(
                  fontSize: 12.0,
                  color: Color.fromARGB(255, 255, 255, 255),
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
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen()

          },
        ),
      ),
    );
  }
}
