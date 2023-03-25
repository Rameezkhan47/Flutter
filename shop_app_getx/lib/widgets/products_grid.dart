import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
    final bool showFavs;

  const ProductsGrid(this.showFavs, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Get.find<Products>();
    // final productsData = Provider.of<Products>(context);
    final products = showFavs?productsData.favoriteItems:productsData.items;
    

    return RefreshIndicator(
      onRefresh: (){return productsData.fetchAndSetProducts();},
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 7 / 8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 10),
          itemBuilder: (context, index) =>  ProductItem(product: products[index],),
              itemCount: products.length,
        
            
              ),
    );
  }
}
