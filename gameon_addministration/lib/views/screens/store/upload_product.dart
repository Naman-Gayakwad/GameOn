import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

class UploadProduct extends StatefulWidget {
  static const routeName = '/UploadProduct';
  const UploadProduct({super.key});

  @override
  State<UploadProduct> createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool get wantKeepAlive => true;
  final ImagePicker picker = ImagePicker();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _shippingChargeController = TextEditingController();

  final List<String> _categories = [
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

  String? _selectedCategory;
  Uint8List? _thumbnailImage;
  List<Uint8List> _images = [];

  bool _isLoading = false;

  Future<void> pickThumbnail() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List bytes = await pickedFile.readAsBytes();
      setState(() {
        _thumbnailImage = bytes;
      });
    } else {
      print('No image selected.');
    }
  }

  choosimage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List bytes = await pickedFile.readAsBytes();
      setState(() {
        _images.add(bytes);
      });
    }
  }

  _uploadImage(Uint8List? image) async {
    String fileName = Uuid().v4();
    Reference ref = _storage.ref().child('productImages').child(fileName);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<List<String>> _uploadImageFromFile() async {
    List<String> uploadedUrls = [];

    for (var img in _images) {
      String fileName = Uuid().v4();
      Reference ref = _storage.ref().child('productImages').child(fileName);
      UploadTask uploadTask = ref.putData(img);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      uploadedUrls.add(downloadUrl);
    }

    return uploadedUrls;
  }

  Future<void> uploadProduct() async {
  if (_thumbnailImage == null || _images.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thumbnail and at least 1 product image are required'),
      ),
    );
    return;
  }

  setState(() => _isLoading = true);

  try {
    String productId = const Uuid().v4();

    String thumbnailUrl = await _uploadImage(_thumbnailImage);
    List<String> imageUrls = await _uploadImageFromFile();

    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .set({
      'productId': productId,
      'name': _nameController.text.trim(),
      'brand': _brandController.text.trim(),
      'price': double.tryParse(_priceController.text) ?? 0.0,
      'productquantity': int.tryParse(_quantityController.text) ?? 0,
      'category': _selectedCategory ?? '',
      'description': _descriptionController.text.trim(),
      'shippingCharge': double.tryParse(_shippingChargeController.text) ?? 0.0,
      'thumbnailUrl': thumbnailUrl,
      'productImages': imageUrls,
      'createdAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product uploaded successfully ✅')),
    );

    clearForm();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  } finally {
    setState(() => _isLoading = false);
  }
}


  void clearForm() {
    _nameController.clear();
    _brandController.clear();
    _priceController.clear();
    _quantityController.clear();
    _descriptionController.clear();
    _shippingChargeController.clear();
    _selectedCategory = null;
    _thumbnailImage = null;
    _images.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Product')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                      controller: _nameController,
                      decoration:
                          const InputDecoration(labelText: 'Product Name')),
                  TextField(
                      controller: _brandController,
                      decoration: const InputDecoration(labelText: 'Brand')),
                  TextField(
                      controller: _priceController,
                      decoration: const InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number),
                  TextField(
                      controller: _quantityController,
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number),
                  TextField(
                      controller: _descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description')),
                  TextField(
                      controller: _shippingChargeController,
                      decoration: const InputDecoration(
                          labelText: 'Shipping Charge (if any)'),
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    hint: const Text('Select Sport Category'),
                    items: _categories.map((category) {
                      return DropdownMenuItem(
                          value: category, child: Text(category));
                    }).toList(),
                    onChanged: (val) {
                      setState(() => _selectedCategory = val);
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: pickThumbnail,
                    icon: const Icon(Icons.image),
                    label: const Text("Pick Thumbnail"),
                  ),
                  const SizedBox(height: 20),
                  if (_thumbnailImage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Image.memory(
                        _thumbnailImage!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: choosimage,
                    icon: const Icon(Icons.image_outlined),
                    label: const Text("Pick Product Images"),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height:
                        200,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: _images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.memory(
                          _images[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: uploadProduct,
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15)),
                    child: const Text('Upload Product'),
                  )
                ],
              ),
            ),
    );
  }
}
