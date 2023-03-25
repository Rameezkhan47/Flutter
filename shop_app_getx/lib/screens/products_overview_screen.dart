import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';

import '../widgets/products_grid.dart';
import '../providers/cart.dart';
import '../widgets//badge.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';

enum FilterOptions {
  // ignore: constant_identifier_names
  Favorites,
  // ignore: constant_identifier_names
  All
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;
  
  @override
  Widget build(BuildContext context) {
        // final mediaQuery = MediaQuery.of(context);
         final deviceSize = Get.size;
            // final deviceSize = MediaQuery.of(context).size;


  final appBar = AppBar(
        title: const Center(child: Text('MyShop')),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  selectedValue == FilterOptions.Favorites
                      ? _showOnlyFavorites = true
                      : _showOnlyFavorites = false;
                });
              },
              icon: const Icon(Icons.more_vert_rounded),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: FilterOptions.Favorites,
                      child: Text('Favorites'),
                    ),
                    const PopupMenuItem(
                        value: FilterOptions.All, child: Text('All'))
                  ]),
          GetBuilder<Cart>(
            init: Cart(),
            builder: (cartController) => CartBadge(
              value: cartController.itemCount.toString(),
            
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Get.toNamed(CartScreen.routeName);
                // Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
          ),
        ],
      );

    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
        future:
        Get.find<Products>().fetchAndSetProducts(),
            // Provider.of<Products>(context, listen: false).fetchAndSetProducts(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(child: Lottie.asset(
                  'assets/loading.json',
                  height: deviceSize.height * 0.2,
                  // width: deviceSize.width,
                  fit: BoxFit.fill,
                ));
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred!'),
            );
          } 
          else {
            return Container(
              height: deviceSize.height*1,
              // height: (mediaQuery.size.height -
              //     appBar.preferredSize.height -
              //     mediaQuery.padding.top) *
              // 1,
              padding: const EdgeInsets.all(15),
              child: ProductsGrid(_showOnlyFavorites));
          }
        },
      ),
      drawer: const AppDrawer(),
    );
  }
}
