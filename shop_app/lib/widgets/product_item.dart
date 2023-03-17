import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import '../providers/cart.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product =
        Provider.of<Product>(context, listen: false); //won't listen to notifications
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, value, child) => IconButton(
              onPressed: () => product.toggleFavoriteStatus(product.id as String),
              color: Theme.of(context).colorScheme.error,
              icon: Icon(product.isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_outline_rounded),
            ),
          ),
          title: Text(
            product.title as String,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(
                product.id as String,
                product.price as double,
                product.title as String,
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added item to cart!'),
                  duration: Duration(seconds: 2),
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
          child: Image.network(
            product.imageUrl as String,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
