import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import './cart.dart';
import 'package:shop_app/models/http_exception.dart';

class OrderItem {
  final String id;
  final double amount;
  final List products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders extends GetxController {
  List<OrderItem> _orders = [];
  final String? authToken;
  final String? userId; 

    Orders(this.authToken, this.userId, this._orders);


  List<OrderItem> get orders {
    return [..._orders];
    
  }

  Future<void> fetchAndSetOrders() async {
    print('in order user id $userId');

    final url = 'https://flutter-41360-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(Uri.parse(url));

    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    // ignore: unnecessary_null_comparison
    if (extractedData == null) {
      
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
        ),
      );


    }
    
    );
    

    _orders = loadedOrders.reversed.toList();

    update();
  }

  Future<void> addOrder(List cartProducts, double total) async {
    final url = 'https://flutter-41360-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    final timeStamp = DateTime.now();
    final response = await http.post(Uri.parse(url),
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price
                  })
              .toList()
        }));

    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timeStamp,
        products: cartProducts,
      ),
    );
    update();
  }

  Future<void> deleteOrder(String id) async {
    final url =
        'https://flutter-41360-default-rtdb.firebaseio.com/orders/$id.json?auth=$authToken';
    final existingOrderIndex = _orders.indexWhere((order) => order.id == id);
    OrderItem? existingOrder = _orders[existingOrderIndex];

    _orders.removeAt(existingOrderIndex);
    update();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _orders.insert(existingOrderIndex, existingOrder);
      update();
      throw HttpException('Could not delete Order');
    }
    existingOrder = null; //clearing from memory
  }
}
