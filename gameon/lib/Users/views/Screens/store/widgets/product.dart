import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gameon/Users/views/Screens/store/widgets/productdetail.dart';

class Product extends StatelessWidget {
  final String categoryName;
  const Product({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final ph = MediaQuery.of(context).size.height;

    final Stream<QuerySnapshot> _productsStream =
        categoryName.toLowerCase() == 'all'
            ? FirebaseFirestore.instance.collection('products').snapshots()
            : FirebaseFirestore.instance
                .collection('products')
                .where('category', isEqualTo: categoryName)
                .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: ph * 0.66,
            child: GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 190 / 300,
              ),
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Productdetail(
                          productData: productData,
                        );
                      }),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 3 / 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.0),
                            child: Image.network(
                              productData['thumbnailUrl'],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8.0, right: 8.0),
                          child: Text(
                            productData['name'],
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            '₹${productData['price']}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              color: Colors.orange.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
