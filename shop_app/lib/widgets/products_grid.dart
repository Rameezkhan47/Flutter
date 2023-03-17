import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
    final bool showFavs;

  const ProductsGrid(this.showFavs, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs?productsData.favoriteItems:productsData.items;
        final mediaQuery = MediaQuery.of(context);


    return RefreshIndicator(
      onRefresh: (){return productsData.fetchAndSetProducts();},
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 5 / 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 10),
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: products[index], //Product()
                // ignore: prefer_const_constructors
                child:  ProductItem(),
                
              ),
              itemCount: products.length,
        
            
              ),
    );
  }
}
