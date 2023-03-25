import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = Get.size;
    // final deviceSize = MediaQuery.of(context).size;

    final orderData = Get.find<Orders>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: const AppDrawer(),
        body: RefreshIndicator(
          onRefresh: () => orderData.fetchAndSetOrders(),
          child: FutureBuilder(
              future: orderData.fetchAndSetOrders(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Lottie.asset(
                      'assets/loading.json',
                      height: deviceSize.height * 0.2,
                      // width: deviceSize.width,
                      fit: BoxFit.fill,
                    ),
                  );
                } else {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('You have no orders'),
                    );
                  } else {
                    return GetBuilder<Orders>(
                        builder: (orderData) =>
                            ListView.builder(
                                itemCount: orderData.orders.length,
                                itemBuilder: (ctx, i) {
                                  return Dismissible(
                                      key: Key(
                                          orderData.orders[i].id.toString()),
                                      direction: DismissDirection.endToStart,
                                      confirmDismiss: (direction) {
                                        return Get.defaultDialog(
                                            radius: 10,
                                            titlePadding:
                                                const EdgeInsets.all(20),
                                            title: 'Are you sure?',
                                            middleText:
                                                'Are you sure you want to delete this order?',
                                            confirm: TextButton(
                                                onPressed: () =>
                                                    Get.back(result: true),
                                                child: const Text("Yes")),
                                            cancel: TextButton(
                                                onPressed: () =>
                                                    Get.back(result: false),
                                                child: const Text("No")));
                                      },
                                      onDismissed: (direction) async {
                                        try {
                                          await Get.find<Orders>()
                                              .deleteOrder(
                                                  orderData.orders[i].id);
                                          // ignore: use_build_context_synchronously
                                          Get.rawSnackbar(
                                            messageText: Text(
                                              'Order successfully deleted',
                                              // ignore: use_build_context_synchronously
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 66, 66, 66),
                                            snackPosition: SnackPosition.BOTTOM,
                                            borderRadius: 10,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            duration:
                                                const Duration(seconds: 2),
                                            isDismissible: true,
                                            dismissDirection:
                                                DismissDirection.horizontal,
                                            forwardAnimationCurve:
                                                Curves.easeOutBack,
                                          );
                                        } catch (e) {
                                          Get.rawSnackbar(
                                            messageText: Text(
                                              'Deleting failed',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 66, 66, 66),
                                            snackPosition: SnackPosition.BOTTOM,
                                            borderRadius: 10,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            duration:
                                                const Duration(seconds: 2),
                                            isDismissible: true,
                                            dismissDirection:
                                                DismissDirection.horizontal,
                                            forwardAnimationCurve:
                                                Curves.easeOutBack,
                                          );
                                        }
                                      },
                                      background: Card(
                                        color: Colors.red,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12.0),
                                              child: Text(
                                                'Delete',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.delete_rounded,
                                              size: 30,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                      child: OrderItem(orderData.orders[i]));
                                }));
                  }
                }
              })),
        ));
  }
}
