import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controllers/products_controller.dart';

import '../screens/edit_product_screen.dart';



class UserProductItem extends StatelessWidget {
  final String? id;
  final String title;
  final String imageUrl;

  const UserProductItem(this.id, this.title, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Get.toNamed(EditProductScreen.routeName, arguments: id);
                // Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Get.find<ProductsController>().deleteProduct(id!);

              },
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
