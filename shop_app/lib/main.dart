import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/splash_screen.dart';
import './screens/auth_screen.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

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
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          //this provider depends on the other provider defined before it (Auth) second argument is type of data you will provide
          create: (_) => Products('', '', []),
          update: (ctx, auth, previousProducts) => Products(
              //the Auth object we gave before to the provider will now have it available to us in the callback (2nd argument)
              //whenever Auth changes, this provider will also be rebuilt //3rd argument is the previous state snapshot of Products ›
              auth.token, auth.userId,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
            create: (ctx) => Orders('', '', []),
            update: (ctx, auth, previousOrders) => Orders(
                auth.token, auth.userId, previousOrders!.orders)),
      ],

      child: Consumer<Auth>(
          //will listen to Auth and on any change it will rebuild the widget
          builder: (ctx, auth, _) => //second argument is Auth data
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: MaterialApp(
                  title: 'Shop App',
                  theme: ThemeData(
                    primarySwatch: Colors
                        .pink, //sets the theme for the app, the widgets will inherit shades of primary swatch
                    colorScheme: const ColorScheme(
                      primary: Color.fromARGB(235, 255, 162, 0),
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
                        titleMedium:
                            TextStyle(fontSize: 16.0, fontFamily: 'Quicksand'),
                        titleSmall: TextStyle(
                            fontSize: 12.0,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily:
                                'OpenSans'), // sets theme for different texts
                        displayLarge:
                            TextStyle(fontSize: 24.0, color: Colors.white),
                        titleLarge: TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w400),
                        bodyMedium: TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w800),
                        bodySmall: TextStyle(
                            fontSize: 12.0,
                            color: Color.fromARGB(255, 114, 114, 114)),
                        displaySmall: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'OpenSans',
                            color: Color.fromARGB(255, 255, 255, 255))),
                  ),
                  // home:   SplashScreen(),
                  home: auth.isAuth
                      ?  const ProductsOverviewScreen()
                      : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (context, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting ? const SplashScreen() : const AuthScreen()

                      ), //once the user is authenticated, it will notify the listeners and the consumer widget will
                  //rebuild and based on the terniary operator above will render the widget that aligns with the condition
                  routes: {
                    ProductDetailScreen.routeName: (ctx) =>
                        const ProductDetailScreen(),
                    CartScreen.routeName: (ctx) => const CartScreen(),
                    OrdersScreen.routeName: (ctx) => const OrdersScreen(),
                    UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
                    EditProductScreen.routeName: (ctx) =>
                        const EditProductScreen(),
                  },
                ),
              )),
    );
  }
}
