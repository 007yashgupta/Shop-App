import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

import '../providers/products_provider.dart';
import '../widgets/product_item.dart';


class ProductGrid extends StatelessWidget {

  var isFavs;

  ProductGrid(this.isFavs);


  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = isFavs ? productsData.favourites : productsData.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,


      ), 
      itemBuilder: (context, index) => ChangeNotifierProvider.value(value: products[index],child: ProductItem(
        //  products[index].id,
        //  products[index].title, 
        //  products[index].imageUrl,
         )
         ),
      itemCount: products.length,
      );
  }
}