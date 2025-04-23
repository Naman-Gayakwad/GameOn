import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NationalCompetition extends StatefulWidget {
  static const String routeName = '/NationalCompetition';

  @override
  State<NationalCompetition> createState() => _NationalCompetitionState();
}

class _NationalCompetitionState extends State<NationalCompetition> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController venueController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? _selectedSport;
  bool isPaid = false;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? eventDate;
  Uint8List? _selectedImage;
  final picker = ImagePicker();

  List<String> sportsList = [
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

  InputDecoration inputStyle(String label) => InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      );

  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<void> pickDate(String type) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (type == 'start') startDate = picked;
        if (type == 'end') endDate = picked;
        if (type == 'event') eventDate = picked;
      });
    }
  }

  Future<void> pickImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List bytes = await pickedFile.readAsBytes();
      setState(() {
        _selectedImage = bytes;
      });
    } else {
      print('No image selected.');
    }
  }

  _uploadImage(Uint8List? image) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('national_competitions/$fileName');
      UploadTask uploadTask = storageRef.putData(image!);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Image upload error: $e');
      return null;
    }
  }

  Future<void> submitCompetition() async {
    if (!_formKey.currentState!.validate() ||
        _selectedSport == null ||
        startDate == null ||
        endDate == null ||
        eventDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields properly')),
      );
      return;
    }
    EasyLoading.show(status: 'Uploading...');

    String? imageUrl;
    if (_selectedImage != null) {
      imageUrl = await _uploadImage(_selectedImage!);
    }

    final data = {
      'name': nameController.text.trim(),
      'venue': venueController.text.trim(),
      'description': descriptionController.text.trim(),
      'sport': _selectedSport,
      'isPaid': isPaid,
      'startDate': startDate,
      'endDate': endDate,
      'eventDate': eventDate,
      'bannerUrl': imageUrl ?? '',
      'approved': true,
      'nationalLevel': true,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance
        .collection('nationalcompetitions')
        .add(data);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('National competition uploaded!')),
    );
    clearForm();
    EasyLoading.dismiss();
  }
  void clearForm() {
    nameController.clear();
    venueController.clear();
    descriptionController.clear();
    _selectedSport = null;
    isPaid = false;
    startDate = null;
    endDate = null;
    eventDate = null;
    _selectedImage = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload National Competition"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shadowColor: Colors.teal.shade100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: inputStyle("Competition Name"),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    decoration: inputStyle("Select Sport"),
                    items: sportsList.map((sport) {
                      return DropdownMenuItem(
                        value: sport,
                        child: Text(sport),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedSport = value),
                    validator: (value) =>
                        value == null ? 'Please select a sport' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: venueController,
                    decoration: inputStyle("Venue / Location"),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: descriptionController,
                    decoration: inputStyle("Description"),
                    maxLines: 6,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text("Is it a Paid Event?"),
                    value: isPaid,
                    onChanged: (val) => setState(() => isPaid = val),
                  ),
                  const SizedBox(height: 20),
                  Text("Application Period",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => pickDate('start'),
                          icon: const Icon(Icons.date_range),
                          label: Text(startDate == null
                              ? "Start Date"
                              : 'Start: ${formatDate(startDate)}'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => pickDate('end'),
                          icon: const Icon(Icons.event),
                          label: Text(endDate == null
                              ? "End Date"
                              : 'End: ${formatDate(endDate)}'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text("Date of Event",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () => pickDate('event'),
                    icon: const Icon(Icons.event_available),
                    label: Text(eventDate == null
                        ? "Select Event Date"
                        : 'Event: ${formatDate(eventDate)}'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: pickImage,
                        icon: const Icon(Icons.image),
                        label: const Text("Upload Banner"),
                      ),
                      const SizedBox(width: 10),
                      if (_selectedImage != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Image.memory(
                            _selectedImage!,
                            height: 150,
                            width: 400,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: submitCompetition,
                    child: const Text("Upload Competition"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 30),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
