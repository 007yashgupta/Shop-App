import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart' as ci;
import'../providers/cart.dart';
import '../providers/orders.dart';

class CartScreen extends StatefulWidget {

  static const routeName ='/cart-screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override

  Widget build(BuildContext context ) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('Your Cart'),
      ),
      body:Column(children: <Widget>[
        Card(
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total', style: TextStyle(fontSize: 20),),

                Spacer(),
                
                Chip(label: Text('\$${cart.totalAmount.toStringAsFixed(2)}', style: TextStyle(color: Colors.white),),
                backgroundColor: Theme.of(context).primaryColor,
                ),
                TextButton(onPressed: () async{

                  try {
                    await Provider.of<Orders>(context,listen: false).addOrder(cart.items.values.toList(), cart.totalAmount);
                  cart.clear();

                  } catch (error) {
                    print(error);

                  }

                  


                }, child: Text('ORDER NOW ',style: TextStyle(color: Theme.of(context).primaryColor,),),),

              ],
              ),

          ),
        ),
        SizedBox(height: 10,),
        Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index)=> ci.CartItem(
              cart.items.values.toList()[index].id!,
              cart.items.keys.toList()[index]!,
               cart.items.values.toList()[index].price,
                cart.items.values.toList()[index].quantity,

                 cart.items.values.toList()[index].title
                 ),
            itemCount: cart.itemCount,)

           ),
              ],)

    );
  }
}