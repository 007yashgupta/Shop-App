import 'package:flutter/material.dart';


class Product with ChangeNotifier{

  final String? id;
  final double price;
  bool isFavourite;
  final String description;
  final String title;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false
    });

    void toggleFavoriteStatus() {
      isFavourite = ! isFavourite;
      notifyListeners();


    }

}