import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/app_drawer.dart';
import '../screens/cart_screen.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';

import '../widgets/products_grid.dart';

enum FilterOptions {
  showAll,
  onlyFavourites,
}

class ProductsOverview extends StatefulWidget {
  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  var _isFavouriteOnly = false;
  bool _isLoading = false;
  bool _isInitState = true;

  @override

  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_isInitState) {

      setState(() {
        _isLoading = true;
        
      });

      Provider.of<Products>(context).fetchAndSetProducts().then((_) => setState((){
        _isLoading = false;
      }));
      



    }
    _isInitState = false;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.showAll,
              ),
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: FilterOptions.onlyFavourites,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.onlyFavourites) {
                  _isFavouriteOnly = true;
                } else {
                  _isFavouriteOnly = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
          ),
          Consumer<Cart>(builder:(_ , cart , ch) =>   BadgeUs(
           
            value: cart.itemCount.toString(),
            
             child: ch!,
          ),
          child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: (){
                Navigator.of(context).pushNamed(CartScreen.routeName);
              }),
          ),
 
        ],
      ),
      body: _isLoading ? Center(
        child: CircularProgressIndicator(color: Theme.of(context).primaryColor) ,
      ) : ProductGrid(_isFavouriteOnly),
    );
  }
}
