import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';


import '../widgets/products_grid.dart';
import '../providers/cart.dart';
import '../widgets//badge.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions {
  // ignore: constant_identifier_names
  Favorites,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
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

                  Consumer<Cart>(
            builder: (_, cart, ch) => CartBadge(
                  value: cart.itemCount.toString(),
                  child: ch as Widget,
                ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {Navigator.of(context).pushNamed(CartScreen.routeName);},
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 100),
          ),
          ProductsGrid(_showOnlyFavorites)
        ],
      ),
            drawer: AppDrawer(),

    );
  }
}
