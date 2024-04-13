import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';


class EditProductScreen extends StatefulWidget {


  


  static const routeName ='/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {


  bool _initStateValue = true;
  bool _isLoading = false;
  
  var _initValues = {
    'title' : '',
    'description' : '',
    'price' : '',
    'imageUrl' : '',
  };
  final _priceFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  var editedProduct = Product(id: null, title: '', description: '', price: 0, imageUrl: '' );
  
  @override

  void initState() {

    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);


  }

  @override

  void didChangeDependencies() {
    if(_initStateValue)
    {
      final productId = ModalRoute.of(context)!.settings.arguments as String?;


      if(productId != null)
      {
        editedProduct  = Provider.of<Products>(context,listen: false).findById(productId);
        _initValues = {
          'title' : editedProduct.title,
          'description' : editedProduct.description,
          'price' : editedProduct.price.toString(),
          'imageUrl' : '',

        };
        _imageUrlController.text = editedProduct.imageUrl;

      }


    }
    _initStateValue = false;
    super.didChangeDependencies();
    

   

    

    

  }



  void _updateImageUrl() {

    if(! _imageUrlFocusNode.hasFocus) {

      if(_imageUrlController.text.isEmpty || (_imageUrlController.text.startsWith('http') && _imageUrlController.text.startsWith('https')) || (_imageUrlController.text.endsWith('.jpg') && _imageUrlController.text.endsWith('.jpeg') && _imageUrlController.text.endsWith('png'))) {

        return;

      }
      setState(() {
        
      });
    }

  }

  Future<void> _saveForm ()  async{

    final formValidate = _form.currentState!.validate();

    if(!formValidate) {
      return;
    }

    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if(editedProduct.id != null) {

      await Provider.of<Products>(context , listen: false).updateProduct(editedProduct.id!, editedProduct);
      Navigator.of(context).pop();



    }
    else {

      try {
       await Provider.of<Products>(context,listen: false).addProduct(editedProduct);


      } catch (error) {

        await showDialog(context: context, builder: (ctx)=>AlertDialog(
          content: const Text('Something went wrong!') ,
          title: const Text('An error occured!'),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Okay')),
          ],

        ));

        

      }

      finally {

        setState(() {
          _isLoading = false;
          
        });
        Navigator.of(context).pop();
      }

      
      

      

    }
    
    
   


  }

  @override

  void dispose()
  {
    super.dispose();

    _imageUrlFocusNode.removeListener(_updateImageUrl);

    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
  }


  @override
  

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('Edit Product'),
        actions: [
          IconButton(onPressed: (){
            _saveForm();
          }, icon: Icon(Icons.save),color: Colors.white,),
        ],
        
      ),
      
      body: _isLoading ?  Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,

        ),
        

      ) : Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(
                    labelText: 'Title'
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: ( _ ) {

                    FocusScope.of(context).requestFocus(_priceFocusNode);

                  },
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'Please provide a value.';
                    }

                    return null;
                  } ,
                  onSaved: (newValue) {

                    editedProduct = Product(id: editedProduct.id, title: newValue!, description: editedProduct.description, price: editedProduct.price, imageUrl: editedProduct.imageUrl,isFavourite: editedProduct.isFavourite);
                    

                  },
      
      
      
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(
                    labelText: 'Price'
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: ( _ ) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                    
                  },

                  validator: (value) {

                    if(value!.isEmpty) {

                      return 'Please enter a price.';

                    }

                    if(double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }

                    if(double.parse(value) <= 0) {

                      return 'Please enter a price greater than 0.';

                    }

                    return null;
                    

                  },
                   onSaved: (newValue) {

                    editedProduct = Product(id: editedProduct.id, title: editedProduct.title, description: editedProduct.description, price: double.parse(newValue!), imageUrl: editedProduct.imageUrl,isFavourite: editedProduct.isFavourite);
                    

                  },
      
       
      
                ),
                 TextFormField(
                  initialValue: _initValues['description'],
                  
                  decoration: InputDecoration(
                    labelText: 'Description'
                  ),
                 
                  keyboardType: TextInputType.multiline,
                  maxLines: 3, 
                  focusNode: _descriptionFocusNode,
                  onSaved: (newValue) {

                    editedProduct = Product(id: editedProduct.id, title: editedProduct.title, description: newValue!, price: editedProduct.price, imageUrl: editedProduct.imageUrl,isFavourite: editedProduct.isFavourite);
                    

                  },

                  validator: (value) {

                    if(value!.isEmpty) {

                      return 'Please enter a description';

                    }

                    if(value.length<10) {
                      return 'Should be atleast 10 characters long.';
                    }

                    return null;
                  },
      
      
      
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey
                          ),
                      ), 
                      child: _imageUrlController.text.isEmpty ? Text('Enter a URL') : FittedBox(
                          child: Image.network(
                         _imageUrlController.text,
                            fit: BoxFit.cover,
                          
                          ),
                        ),
                      
                      ),

                    
                    Expanded(
                      child: TextFormField(
                        
                        controller: _imageUrlController,
                        decoration: InputDecoration(
                          labelText: 'Image URL'
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done ,
                        focusNode: _imageUrlFocusNode,
                        validator: (value) {

                          if(value!.isEmpty) {

                            return 'Please enter an image URL.';

                          }

                          if(!value.startsWith('http') && !value.startsWith('https')) {

                            return 'Please enter a valid URL.';
                          }

                          if(!value.endsWith('.jpg') && !value.endsWith('.jpeg') && !value.endsWith('png')) {

                            return 'Please enter a valid image URL.';
                          }

                          return null;




                        },
                         onSaved: (newValue) {

                         editedProduct = Product(id: editedProduct.id, title: editedProduct.title, description: editedProduct.description, price: editedProduct.price, imageUrl: newValue!,isFavourite: editedProduct.isFavourite);
                    

                  },
                        onFieldSubmitted: (_){
                          _saveForm();
                        },
                      ),
                    ),
                  ],

                ),
              ],
            ),
          ),
      
          ),
      ),
    );
  }
}