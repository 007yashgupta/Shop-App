import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/edit_product_screen.dart';
import './screens/user_products_screen.dart';
import './screens/orders_screen.dart';
import './providers/orders.dart';
import './providers/cart.dart';
import './screens/products_overview_screen.dart';
import './screens/product_details.dart';
import './screens/cart_screen.dart';
import './providers/products_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  {
    return  MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>Products()),
      ChangeNotifierProvider(create: (_)=>Cart()),
      ChangeNotifierProvider(create: (_)=>Orders()),

    ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.blue,
          ),
          primarySwatch: Colors.purple,
          iconButtonTheme:  IconButtonThemeData(
            style: ButtonStyle(
              iconColor: MaterialStatePropertyAll(Colors.orange)
            )
            
          ),
          // accentColor: Colors.deepOrange,

          fontFamily: 'Lato' ,  
        ),
        home: ProductsOverview(),
        routes: {
          ProductDetailScreen.routeName : (ctx)=>ProductDetailScreen(),
          CartScreen.routeName : (ctx)=>CartScreen(),
          OrdersScreen.routeName : (ctx)=>OrdersScreen(),
          UserProductsScreen.routeName : (ctx)=>UserProductsScreen(),
          EditProductScreen.routeName : (ctx)=>EditProductScreen(),

    
        },
        debugShowCheckedModeBanner: false,
  
    
      ),
      );
    
  }
}

