import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gameon/Users/model/cart_attributes.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttr> _cartItems = {};

  Map<String, CartAttr> get getCartItems {
    return {..._cartItems};
  }

  double calculateTotalAmount() {
    double totalAmount = 0;
    _cartItems.forEach((key, value) {
      totalAmount += value.price * value.productquantity;
    });
    return totalAmount;
  }

  void addProductToCart(
    String productId,
    String name,
    String productImages,
    int productquantity,
    int quantity,
    int price,
  ) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existingCartItem) => CartAttr(
          productId: existingCartItem.productId,
          name: existingCartItem.name,
          productImages: existingCartItem.productImages,
          productquantity: existingCartItem.productquantity + 1,
          quantity: existingCartItem.quantity,
          price: existingCartItem.price,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartAttr(
          productId: productId,
          name: name,
          productImages: productImages,
          productquantity: productquantity,
          quantity: quantity,
          price: price,
        ),
      );
    }
    saveCartToPrefs();
    notifyListeners();
  }

  void increament(CartAttr cartAttr) {
    cartAttr.increaseProductQuantity();
    saveCartToPrefs();
    notifyListeners();
  }

  void decreament(CartAttr cartAttr) {
    cartAttr.decreaseProductQuantity();
    saveCartToPrefs();
    notifyListeners();
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    saveCartToPrefs();
    notifyListeners();
  }

  void removeAllItems() {
    _cartItems.clear();
    saveCartToPrefs();
    notifyListeners();
  }

  /// ✅ Save cart to SharedPreferences
  Future<void> saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final cartMap = _cartItems.map((key, item) => MapEntry(key, item.toJson()));
    prefs.setString('cartData', jsonEncode(cartMap));
  }

  /// ✅ Load cart from SharedPreferences
  Future<void> loadCartFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cartData');
    if (cartData != null) {
      final decoded = jsonDecode(cartData) as Map<String, dynamic>;
      _cartItems = decoded.map(
        (key, value) => MapEntry(key, CartAttr.fromJson(value)),
      );
      notifyListeners();
    }
  }
}
