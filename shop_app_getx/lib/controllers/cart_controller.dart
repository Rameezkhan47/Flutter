import 'package:flutter/foundation.dart';
import 'package:get/get.dart';


class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class CartController extends GetxController {
   Map<String, CartItem> _items = {};

  Map get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }


  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    update();
  }

  void removeItem(String productId){
    _items.remove(productId);
      update();

  }

    void clear() {
    _items = {};
    update();
  }
  
}
