import 'package:flutter/material.dart';

class CartAttr with ChangeNotifier {
  final String productId;
  final String name;
  final String productImages;
  int productquantity;
  int quantity;
  final int price;

  CartAttr({
    required this.productId,
    required this.name,
    required this.productImages,
    required this.productquantity,
    required this.quantity,
    required this.price,
  });

  void increaseProductQuantity() {
    productquantity++;
    notifyListeners();
  }

  void decreaseProductQuantity() {
    productquantity--;
    notifyListeners();
  }

  // Convert CartAttr to Map
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'productImages': productImages,
      'productquantity': productquantity,
      'quantity': quantity,
      'price': price,
    };
  }

  // Create CartAttr from Map
  factory CartAttr.fromJson(Map<String, dynamic> json) {
    return CartAttr(
      productId: json['productId'],
      name: json['name'],
      productImages: json['productImages'],
      productquantity: json['productquantity'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
