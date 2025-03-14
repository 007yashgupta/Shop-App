import 'package:flutter/material.dart';
import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Drawer(

      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop,color: Theme.of(context).primaryColor,),
            title: Text('Shop'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
           ListTile(
            leading: Icon(Icons.payment,color: Theme.of(context).primaryColor,),
            title: Text('Orders'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.edit,color: Theme.of(context).primaryColor,),
            title: Text('Edit Orders'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),

        ],
      ),



    );




  }




}