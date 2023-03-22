import 'package:flutter/material.dart';
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
    final deviceSize = MediaQuery.of(context).size;

    final orderData = Provider.of<Orders>(context, listen: false);
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
                    return Consumer<Orders>(
                        builder: (context, orderData, child) =>
                            ListView.builder(
                                itemCount: orderData.orders.length,
                                itemBuilder: (ctx, i) {
                                  return Dismissible(
                                      key: Key(
                                          orderData.orders[i].id.toString()),
                                      direction: DismissDirection.endToStart,
                                      confirmDismiss: (direction) {
                                        return showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: const Text('Are you sure?'),
                                            content: const Text(
                                              'Are you sure you want to delete this order?',
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('No'),
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(false);
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('Yes'),
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(true);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      onDismissed: (direction) async {
                                        try {
                                          await Provider.of<Orders>(context,
                                                  listen: false)
                                              .deleteOrder(
                                                  orderData.orders[i].id);
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                            'Order successfully deleted',
                                            // ignore: use_build_context_synchronously
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                            textAlign: TextAlign.center,
                                          )));
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                            'Deleting failed!',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                            textAlign: TextAlign.center,
                                          )));
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
