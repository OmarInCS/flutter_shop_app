import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Product.empty() : this(id: "", title: "", description: "", price: 0, imageUrl: "");

  void toggleIsFavorite() {
    this.isFavorite = !this.isFavorite;
    notifyListeners();
  }
}
