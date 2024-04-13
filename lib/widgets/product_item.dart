import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_details.dart';


class ProductItem extends StatelessWidget {

  // final String id;
  // final String title;
  // final String imageUrl;


  // ProductItem(this.id,this.title,this.imageUrl);


  @override

  Widget build(BuildContext context)
  {

    final product = Provider.of<Product>(context,listen: false);
    final cart = Provider.of<Cart>(context,listen: false);


    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,arguments: product.id


          );
          
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            ),
            footer: Consumer<Product>(
              builder: (context, value, child) => GridTileBar(
                leading: IconButton(onPressed: (){
                  value.toggleFavoriteStatus();
                }, icon: Icon(value.isFavourite ? Icons.favorite : Icons.favorite_border ,color: Colors.orange,)),
                backgroundColor: Colors.black54,
               title : Text(
                product.title,
                textAlign: TextAlign.center,
              ),
              trailing: IconButton(onPressed: (){
                cart.addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item added to the Cart!'),
                    duration: Duration(seconds: 5),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: (){
                        cart.removeSingleItem(product.id!);
                      }),

                  ),

                );
              }, icon: Icon(Icons.shopping_cart,color: Colors.orange,)),
                    ),
              
            ),
        ),
      ),
    );



  }


}