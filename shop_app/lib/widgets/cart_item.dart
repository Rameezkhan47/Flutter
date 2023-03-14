import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.id, this.productId, this.price, this.quantity, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children:  [
            const Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Text("Delete", style: Theme.of(context).textTheme.titleMedium, )
          ],
        ),
        
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){cart.removeItem(productId);},

      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 255, 123, 0),
                foregroundColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: FittedBox(
                    child: Text('\$${price.toStringAsFixed(2)}'),
                  ),
                )),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity).toStringAsFixed(2)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
