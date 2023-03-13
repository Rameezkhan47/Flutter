import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum FilterOptions {
  // ignore: constant_identifier_names
  Favorites,
  All
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  selectedValue == FilterOptions.Favorites
                      ? _showOnlyFavorites = true
                      : _showOnlyFavorites = false;
                });
              },
              icon: Icon(Icons.more_vert_rounded),
              itemBuilder: (_) => [
                    PopupMenuItem(child: Text('Favorites'), value: FilterOptions.Favorites,),
                    PopupMenuItem(child: Text('All'), value: FilterOptions.All)
                  ]
                  )
        ],
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 100),
          ),
          ProductsGrid(_showOnlyFavorites)
        ],
      ),
    );
  }
}
