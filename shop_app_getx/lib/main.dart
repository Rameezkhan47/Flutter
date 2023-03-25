import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/splash_screen.dart';
import './screens/auth_screen.dart';

import 'controllers/products_controller.dart';
import 'models/product.dart';
import 'controllers/cart_controller.dart';
import 'controllers/orders_controller.dart';
import 'controllers/auth_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetMaterialApp(
        title: 'Shop App GetX',
        initialBinding: BindingsBuilder(() {
          Get.put<AuthController>(AuthController());
          var auth = Get.find<AuthController>();
          Get.lazyPut(() => ProductsController(auth.token, auth.userId, []));
          Get.put<CartController>(CartController());
          Get.lazyPut<OrdersController>((() => OrdersController(auth.token, auth.userId, [])));
        }),

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
              displaySmall: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'OpenSans',
                  color: Color.fromARGB(255, 255, 255, 255)),
              labelMedium: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'OpenSans',
                  color: Color.fromARGB(255, 255, 255, 255))),
        ),
        // home:   SplashScreen(),
        home: GetBuilder<AuthController>(
            init: AuthController(),
            builder: (authController) => authController.isAuth
                ? const ProductsOverviewScreen()
                : FutureBuilder(
                    future: authController.tryAutoLogin(),
                    builder: (context, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? const SplashScreen()
                            : const AuthScreen())),
        // home: auth.isAuth
        //     ? const ProductsOverviewScreen()
        // : FutureBuilder(
        //     future: auth.tryAutoLogin(),
        //     builder: (context, authResultSnapshot) =>
        //         authResultSnapshot.connectionState ==
        //                 ConnectionState.waiting
        //             ? const SplashScreen()
        //             : const AuthScreen()), //once the user is authenticated, it will notify the listeners and the consumer widget will
        //rebuild and based on the terniary operator above will render the widget that aligns with the condition
        getPages: [
          GetPage(
              name: ProductDetailScreen.routeName,
              page: () => const ProductDetailScreen()),
          GetPage(name: CartScreen.routeName, page: () => const CartScreen()),
          GetPage(
              name: OrdersScreen.routeName, page: () => const OrdersScreen()),
          GetPage(
              name: UserProductsScreen.routeName,
              page: () => const UserProductsScreen()),
          GetPage(
              name: EditProductScreen.routeName,
              page: () => const EditProductScreen()),
        ],
      ),
    );
  }
}
