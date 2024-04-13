import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './cart.dart';

class OrderItem {
  final String? id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async{

    final url = Uri.parse('https://shop-b4392-default-rtdb.firebaseio.com/orders.json');
    


    
    try {

      final timeStamp = DateTime.now();

      
    
      final response = await http.post(
        url ,
        body: json.encode({
          'amount' : total,
          'dateTime' : timeStamp.toIso8601String(),
          'products' : cartProducts.map((e) => {
            'id' : e.id,
            'title' : e.title,
            'quantity' : e.quantity,
            'price' : e.price,


          }).toList(),

        })
        );

         _orders.insert(
      0,
      OrderItem(
          id: json.decode( response.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: timeStamp),
    );
    print(json.decode(response.body));
    notifyListeners();
  }
      

     catch (error) {
      print(error);
      throw(error);
    }
   

  





}
}
