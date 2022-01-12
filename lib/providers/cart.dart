import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  int quantity;
  final double price;
  final String productId;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.productId,
  });

  void decreaseQuantity() {
    quantity--;
  }
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {

    return _items.length == 0 ? 0 :
        _items.entries
        .map((e) => e.value.price * e.value.quantity)
        .reduce((value, element) => value + element);
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
          productId: productId,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
          productId: productId,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (_items[productId]!.quantity > 1) {
      _items.update(productId, (item) => item..decreaseQuantity());
    }
    else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
