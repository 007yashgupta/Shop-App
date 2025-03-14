

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exceptions.dart' as http_exceptions;
import 'product.dart';

class Products with ChangeNotifier {

  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // var _showFavouritesOnly = false;

  // void showFavouritesOnly() {
  //   _showFavouritesOnly = true;
  //   notifyListeners();
  // }

  //  void showAll() {
  //   _showFavouritesOnly = false;
  //   notifyListeners();
  // }

  List<Product> get items {

    // if(_showFavouritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavourite).toList();

    // }
    return [... _items];
  }

  List<Product> get favourites {

    // if(_showFavouritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavourite).toList();

    // }
    return _items.where((prodItem) => prodItem.isFavourite).toList();

  }



  Product findById(String id)
  {
    return items.firstWhere((product) => product.id == id);
  }

  Future<void>  addProduct  (Product product) async
  {

    const  url = 'https://shop-b4392-default-rtdb.firebaseio.com/products1.json';

    try{
      final response = await http.post(Uri.parse(url),
      body: json.encode(
      {
        'title' : product.title,
        'imageUrl' : product.imageUrl,
        'price' : product.price,
        'description' : product.description,
        'isFavourite' : product.isFavourite,
      }


    ), );
    final newProduct = Product(id: json.decode(response.body) ['name'], title: product.title, description: product.description, price: product.price, imageUrl: product.imageUrl);

      _items.add(newProduct); 
    
      notifyListeners();

    } catch 
       (error) {
        print(error);
        throw(error);
      }

   
    
  }

  Future<void>  fetchAndSetProducts  () async {

    const url = 'https://shop-b4392-default-rtdb.firebaseio.com/products1.json';
    try {

      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String,dynamic>;
      final List<Product> loadedProducts =[];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(id: prodId , title: prodData['title'] ?? 'def_TITLE', description: prodData['description'] ?? 'def_DES', price: prodData['price'] ?? 0, imageUrl: prodData['imageUrl'] ?? 'def')
        );
        _items = loadedProducts;
        notifyListeners();

       });

      

    } catch (error) {
      print(error);
      throw(error);
    }

    


  }
  


  Future<void> updateProduct(String id,Product newProduct) async {

    final url = 'https://shop-b4392-default-rtdb.firebaseio.com/products1/$id.json';

    try {
       await http.patch(Uri.parse(url),body: json.encode(   {
        'title' : newProduct.title,
        'imageUrl' : newProduct.imageUrl,
        'price' : newProduct.description,
        'description' : newProduct.description,
      }) 
   



    );
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    print(prodIndex);
    if(prodIndex == -1)
    {
      return;
    }
    _items[prodIndex] = newProduct;
    notifyListeners();

  

    } catch(error){
      print(error);
      print('not deleted');
    }
    

  

      


  

    
  }

  Future<void> deleteProduct(String id) async {

    final url = 'https://shop-b4392-default-rtdb.firebaseio.com/products1/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(Uri.parse(url));
    if(response.statusCode >=400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw http_exceptions.HttpExceptions('could not delete product');

      
    }
    
    

  }
    
       

       

     
  

}