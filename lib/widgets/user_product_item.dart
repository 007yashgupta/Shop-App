import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../screens/edit_product_screen.dart';



class UserProductItem extends StatelessWidget {
 
  final String? productId;
  final String title;
  final String imageUrl;

  UserProductItem(this.productId,this.title,this.imageUrl);

  @override
  Widget build(BuildContext context) {

    final scaffold = ScaffoldMessenger.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          title

        ),
        trailing: Container(
          width: 100,
          
          child: Row(
            children: <Widget>[
              IconButton(onPressed: (){
                Navigator.of(context).pushNamed(EditProductScreen.routeName , arguments: productId);
              }, icon: Icon(Icons.edit),color: Theme.of(context).primaryColor),
              IconButton(onPressed: () async{

                try {
                  await Provider.of<Products>(context,listen: false).deleteProduct(productId!);
                } catch (error) {

                  scaffold.showSnackBar(
                   const SnackBar(
                      content: Text('Deleting failed',textAlign: TextAlign.center,),
                      duration: Duration(seconds: 5),
                      ),

                      );


                }
                
                

              }, icon: Icon(Icons.delete),color: Theme.of(context).errorColor,),
            ],
          ),
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            imageUrl
          ),
        ), 

    
      ),
    ); 
  
  
  }



}