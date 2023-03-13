import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);
  // not using instance variables as we are using provider approach

  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context,
        listen: false); //wont listen to notifications

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (context, value, child) => IconButton(
                  onPressed: () => product.toggleFavoriteStatus(),
                  color: Theme.of(context).colorScheme.error,
                  icon: Icon(product.isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded)),
            ),
            title: Text(
              product.title, style: Theme.of(context).textTheme.titleSmall, 
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_shopping_cart_rounded,
                    color: Theme.of(context).colorScheme.primary))),
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
