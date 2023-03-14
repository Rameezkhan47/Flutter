import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart; //only interested in cart import
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(children: [
        Card(
          elevation: 3,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Spacer(),
                Chip(
                  label: Text(
                    '\$ ${cart.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<Orders>(context, listen: false).addOrder(
                      cart.items.values.toList(),
                      cart.totalAmount,

                    );

                    // cart.items.forEach((key, value) { print('${key}:  ${value.id},  ${value.title},  ${value.quantity},  ${value.price}');});

                    cart.clear();
                  },
                  child: Text('Order Now', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (ctx, i) => CartItem(
              cart.items.values.toList()[i].id,
              cart.items.keys.toList()[i],
              cart.items.values.toList()[i].price,
              cart.items.values.toList()[i].quantity,
              cart.items.values.toList()[i].title,
            ),
          ),
        )
      ]),
    );
  }
}
