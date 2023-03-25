import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    
    // final product = Get.find<Product>();
    // final product = Provider.of<Product>(context,
    //     listen: false); //won't listen to notifications
    final cart = Get.find<Cart>();
    final authData = Get.find<Auth>();

    // final cart = Provider.of<Cart>(context, listen: false);
    // final authData = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: StatefulBuilder(builder: (context, setState) => IconButton(
              onPressed: () {
                setState(() {
                  product.toggleFavoriteStatus(
                      authData.token as String, authData.userId as String);
                });
              },
              color: Theme.of(context).colorScheme.error,
              icon: Icon(product.isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_outline_rounded),
            )),


          // leading: GetBuilder<Product>(builder: (productController)=>IconButton(
          //     onPressed: () => product.toggleFavoriteStatus(
          //         authData.token as String, authData.userId as String),
          //     color: Theme.of(context).colorScheme.error,
          //     icon: Icon(product.isFavorite
          //         ? Icons.favorite_rounded
          //         : Icons.favorite_outline_rounded),
          //   ),),
          
          // Consumer<Product>(
          //   builder: (context, value, child) => IconButton(
          //     onPressed: () => product.toggleFavoriteStatus(
          //         authData.token as String, authData.userId as String),
          //     color: Theme.of(context).colorScheme.error,
          //     icon: Icon(product.isFavorite
          //         ? Icons.favorite_rounded
          //         : Icons.favorite_outline_rounded),
          //   ),
          // ),
          title: Text(
            product.title,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(
                product.id as String,
                product.price,
                product.title,
              );
              Get.rawSnackbar(
                  messageText: Text(
                    'Item added to cart',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  backgroundColor: const Color.fromARGB(255, 66, 66, 66),
                  snackPosition: SnackPosition.BOTTOM,
                  borderRadius: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  duration: const Duration(seconds: 1),
                  isDismissible: true,
                  dismissDirection: DismissDirection.horizontal,
                  forwardAnimationCurve: Curves.easeOutBack,
                  animationDuration: const Duration(milliseconds: 800),
                  mainButton: TextButton(
                      onPressed: () {
                        cart.removeItem(product.id as String);
                      },
                      child: const Text('UNDO')));
            },
            icon: Icon(
              Icons.add_shopping_cart_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () =>
              Get.toNamed(ProductDetailScreen.routeName, arguments: product.id),
          // Navigator.of(context)
          //     .pushNamed(ProductDetailScreen.routeName, arguments: product.id),
          child: Hero(
            tag: product.id as String,
            child: FadeInImage(
                placeholder: const AssetImage('assets/placeholder.png'),
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
