import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context,
        listen: false); //won't listen to notifications
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, value, child) => IconButton(
              onPressed: () => product.toggleFavoriteStatus(
                  authData.token as String, authData.userId as String),
              color: Theme.of(context).colorScheme.error,
              icon: Icon(product.isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_outline_rounded),
            ),
          ),
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
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Added item to cart!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeItem(product.id as String);
                    },
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.add_shopping_cart_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id),
          child: Hero(
            tag: product.id as String,
            child: FadeInImage(
              placeholder: const AssetImage('assets/placeholder.png'),
                image: NetworkImage(product.imageUrl), fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
