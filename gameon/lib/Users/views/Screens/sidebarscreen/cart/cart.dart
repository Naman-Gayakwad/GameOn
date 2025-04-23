import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameon/Users/provider/cartprovider.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              _cartProvider.removeAllItems();
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
      ),

      // Cart Items
      body: _cartProvider.getCartItems.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty 🛒',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : ListView.builder(
              itemCount: _cartProvider.getCartItems.length,
              padding: const EdgeInsets.only(bottom: 100),
              itemBuilder: (context, index) {
                final cartData =
                    _cartProvider.getCartItems.values.toList()[index];
                final subtotal = cartData.price * cartData.productquantity;

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            cartData.productImages,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartData.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '₹ ${cartData.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.orange[800],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Subtotal: ₹ ${subtotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  // Decrement Button
                                  IconButton(
                                    icon:
                                        const Icon(Icons.remove_circle_outline),
                                    onPressed: cartData.productquantity == 1
                                        ? null
                                        : () {
                                            _cartProvider.decreament(cartData);
                                          },
                                  ),
                                  Text(
                                    cartData.productquantity.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  // Increment Button
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: cartData.quantity ==
                                            cartData.productquantity
                                        ? null
                                        : () {
                                            _cartProvider.increament(cartData);
                                          },
                                  ),
                                  const Spacer(),
                                  // Remove Item
                                  IconButton(
                                    icon: const Icon(
                                      CupertinoIcons.cart_badge_minus,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      _cartProvider
                                          .removeItem(cartData.productId);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      // Bottom Summary and Checkout
      bottomNavigationBar: _cartProvider.getCartItems.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total Amount',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        '₹ ${_cartProvider.calculateTotalAmount().toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to checkout
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child:
                         Text('Checkout', style: TextStyle(fontSize: 16, color: Colors.white)),
                  )
                ],
              ),
            ),
    );
  }
}
