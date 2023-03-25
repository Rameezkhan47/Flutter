import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await Get.find<Products>()
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = Get.size;
    // final deviceSize = MediaQuery.of(context).size;

    final productsData =  Get.find<Products>();

    final PreferredSizeWidget appBar = AppBar(
      title: const Text('Your Products'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Get.toNamed(EditProductScreen.routeName);
            // Navigator.of(context).pushNamed(EditProductScreen.routeName);
          },
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder(
            future: _refreshProducts(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Lottie.asset(
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

              return GetBuilder<Products>(
                builder: (productsController) {
                  return ListView.builder(
                    itemCount: productsData.items.length,
                    itemBuilder: (_, i) => Column(
                      children: [
                        UserProductItem(
                          productsData.items[i].id,
                          productsData.items[i].title,
                          productsData.items[i].imageUrl,
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}


