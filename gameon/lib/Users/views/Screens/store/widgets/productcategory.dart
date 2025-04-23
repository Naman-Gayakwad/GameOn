import 'package:flutter/material.dart';
import 'package:gameon/Users/views/Screens/store/widgets/product.dart';

class Productcategory extends StatefulWidget {
  const Productcategory({super.key});

  @override
  State<Productcategory> createState() => _ProductcategoryState();
}

class _ProductcategoryState extends State<Productcategory> {
  String? _selectedCategory;

  final List<String> _categories = [
    'All',
    'Archery',
    'Arm Wrestling',
    'Athletics',
    'Badminton',
    'Basketball',
    'Carrom',
    'Chess',
    'Cricket',
    'Cycling',
    'Football',
    'Hockey',
    'Kabaddi',
    'Meditation',
    'Shooting',
    'Skating',
    'Swimming',
    'Table Tennis',
    'Tennis',
    'Volleyball',
    'Wrestling',
    'Yoga',
  ];

  @override
  Widget build(BuildContext context) {
    final ph = MediaQuery.of(context).size.height;
    final pw = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            top: 10.0,
          ),
          child: const Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: ph * 0.06,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = _categories[index];
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: pw * 0.014),
                          padding: EdgeInsets.symmetric(
                              vertical: ph * 0.01, horizontal: pw * 0.04),
                          decoration: BoxDecoration(
                            color: _selectedCategory == _categories[index]
                                ? Colors.blue
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              _categories[index],
                              style: TextStyle(
                                color: _selectedCategory == _categories[index]
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_selectedCategory != null)
          Product(categoryName: _selectedCategory!),
      ],
    );
  }
}
