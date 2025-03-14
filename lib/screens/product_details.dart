import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/products_provider.dart';


class ProductDetailScreen extends StatelessWidget {

  static const routeName = '/product-detailScreen';

  @override

  Widget build(BuildContext context)
  {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context,listen : false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Theme.of(context).appBarTheme.backgroundColor,
        title: Text(loadedProduct.title),
        
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(loadedProduct.imageUrl,fit:BoxFit.cover),
              
      
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal :10),
              child: Text('\$${loadedProduct.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
              
              ),
            ),
            Text(loadedProduct.description,textAlign: TextAlign.center,softWrap: true,)
          ],
        ),
      ),
   
    );

  }

}