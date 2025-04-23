import 'package:flutter/material.dart';
import 'package:gameon/Users/views/Screens/store/widgets/product.dart';
import 'package:gameon/Users/views/Screens/store/widgets/productcategory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String selectedCategory = '';
  String selectedSport = '';

  @override
  void initState() {
    super.initState();
    _loadSavedSport();
  }

  Future<void> _loadSavedSport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isIndoor = prefs.getBool('isIndoor');
    String? sport = prefs.getString('selectedSport');

    setState(() {
      selectedCategory = isIndoor == true ? 'Indoor' : 'Outdoor';
      selectedSport = sport ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final ph = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.lerp(
                    BorderSide(color: Colors.grey, width: 1.0),
                    BorderSide(color: Colors.grey, width: 1.0),
                    0.5,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Productcategory(),
          SizedBox(
            height: ph * 0.02,
          ),
          Product(categoryName: selectedSport)
        ],
      ),
    );
  }
}
