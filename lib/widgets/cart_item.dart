import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {


  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.id,this.productId,this.price,this.quantity,this.title);

  @override
  Widget build(BuildContext context)
  {
   
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
         margin : EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure !'),
            content: Text('Do you want to remove item from the cart ?'),
            actions: [
              TextButton(child: Text('Yes'),onPressed: (){
                Navigator.of(context).pop(true);
                

              },),
              TextButton(
                child: Text('No'),
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
              )

             ], 

          ),
          
          );
        
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context,listen: false).deleteCartItem(productId);
        
      },
      child: Card(
        margin : EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: 
               CircleAvatar(
                child: FittedBox(child: Text('\$${(price * quantity)}')),
            
              ),
            
            title: Text(title),
            subtitle: Text('Total: \$${price * quantity}'),
            trailing: Text('$quantity x'),
          ),),
    
      ),
    );
  }
}