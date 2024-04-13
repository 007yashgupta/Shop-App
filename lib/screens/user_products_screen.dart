import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_product_screen.dart';


import '../providers/products_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {

  static const routeName = '/user-productsScreen';

  Future<void> _refreshProducts(BuildContext context) async{

    try{
      await Provider.of<Products>(context,listen: false).fetchAndSetProducts();

    }
    catch (error) {
      print(error);
    }

    
    


  }

  @override

  Widget build(BuildContext context) {

    var productsData=Provider.of<Products>(context);

    return Scaffold(

      drawer: AppDrawer(),

      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('Your Orders'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routeName);

          },
           icon: const Icon(Icons.add),
           ),
        ],
        


      ),
      body: 
         RefreshIndicator(
          onRefresh: (){
            return _refreshProducts(context);

          },
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: ListView.builder(
              itemBuilder: (context, index) {
                return  Column(
                  children: [
                    UserProductItem(
                      
                      productsData.items[index].id,
                      productsData.items[index].title,
                      productsData.items[index].imageUrl,
           
                    ),
                    Divider(thickness: 1),
                  ],
                );
           
                
              },
              itemCount: productsData.items.length,
              ),
           ),
         ),
        );

    


  }

}