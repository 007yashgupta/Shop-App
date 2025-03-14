import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {

  final ord.OrderItem orderData;

  OrderItem(this.orderData);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {

  var _expanded = false;

  @override
  Widget build(BuildContext context)
  {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[

          ListTile(
            title: Text('\$${widget.orderData.amount}'),
            subtitle: Text(DateFormat('dd MM yyyy hh:mm').format(widget.orderData.dateTime),),
            trailing: IconButton(
              onPressed: (){
                setState(() {
                  _expanded = ! _expanded;
                  
                });
              },
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_less), 
              ),
          ),
          if(_expanded) Container(
            padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 4),
            height: min(widget.orderData.products.length * 20 + 10, 100),
            child: ListView(
              children: widget.orderData.products.map(
                (prod) => Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Text(prod.title,style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text(
                    '${prod.quantity
                    }x \$${prod.price}' ,
                    style: TextStyle(

                      fontSize: 18,
                      color: Colors.grey
                    ),

                  ),
                  ],

                )
                ).toList(),
            ),
          )

        ],
      ),
    );
  }
}