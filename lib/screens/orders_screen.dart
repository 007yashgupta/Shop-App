import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import'../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';


class OrdersScreen extends StatelessWidget {


  static const routeName = '/orders-screen';

  



  @override

  Widget build(BuildContext context)
  {

    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: AppDrawer(),

      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('Your Orders'),

      ),
      body: ListView.builder(
        itemBuilder: (context, index) => OrderItem(orderData.orders[index]) 
      ,itemCount: orderData.orders.length,),

    );

  }


}