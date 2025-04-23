import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gameon/Users/views/Screens/contest/widegts/customtextfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class HostCompetition extends StatefulWidget {
  const HostCompetition({super.key});

  @override
  State<HostCompetition> createState() => _HostCompetitionState();
}

class _HostCompetitionState extends State<HostCompetition> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController venueController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedSport;
  bool isPaid = false;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? eventDate;
  File? selectedImage;
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

  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<void> pickImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef =
          FirebaseStorage.instance.ref().child('competition_banners/$fileName');
      await storageRef.putFile(imageFile);
      return await storageRef.getDownloadURL();
    } catch (e) {
      print('Image upload error: $e');
      return null;
    }
  }

  Future<void> submitCompetition() async {
    if (!_formKey.currentState!.validate() ||
        selectedSport == null ||
        startDate == null ||
        endDate == null ||
        eventDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields properly')),
      );
      return;
    }
    EasyLoading.show(status: 'Submitting...');
    String? imageUrl;
    if (selectedImage != null) {
      imageUrl = await uploadImage(selectedImage!);
    }

    final data = {
      'name': nameController.text.trim(),
      'venue': venueController.text.trim(),
      'description': descriptionController.text.trim(),
      'sport': selectedSport,
      'isPaid': isPaid,
      'startDate': startDate,
      'endDate': endDate,
      'eventDate': eventDate,
      'bannerUrl': imageUrl ?? '',
      'approved': false,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance.collection('competitions').add(data);
    EasyLoading.dismiss();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Competition submitted successfully!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Host a Competition"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shadowColor: Colors.deepPurple.shade100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  StyledInputField(
                      controller: nameController, label: 'Competition Name'),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: inputStyle("Select Sport"),
                    items: sportsList.map((sport) {
                      return DropdownMenuItem(
                        value: sport,
                        child: Text(sport),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => selectedSport = value),
                    validator: (value) =>
                        value == null ? 'Please select a sport' : null,
                  ),
                  const SizedBox(height: 10),
                  StyledInputField(controller: venueController, label: 'Venue'),
                  const SizedBox(height: 10),
                  StyledInputField(
                    controller: descriptionController,
                    label: 'Description',
                    maxLines: 10,
                  ),
                  const SizedBox(height: 15),
                  SwitchListTile(
                    title: const Text("Is it a Paid Event?"),
                    value: isPaid,
                    onChanged: (val) => setState(() => isPaid = val),
                  ),
                  const SizedBox(height: 15),
                  Text("Application Period",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => pickDate('start'),
                          icon: const Icon(Icons.calendar_today),
                          label: Text(
                            startDate == null
                                ? 'Start Date'
                                : 'Start: ${formatDate(startDate)}',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => pickDate('end'),
                          icon: const Icon(Icons.event),
                          label: Text(
                            endDate == null
                                ? 'End Date'
                                : 'End: ${formatDate(endDate)}',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text("Date of Event",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () => pickDate('event'),
                    icon: const Icon(Icons.event_available),
                    label: Text(
                      eventDate == null
                          ? 'Select Event Date'
                          : 'Event: ${formatDate(eventDate)}',
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: pickImage,
                        icon: const Icon(Icons.image),
                        label: const Text("Upload Banner"),
                      ),
                      const SizedBox(width: 10),
                      if (selectedImage != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            selectedImage!,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: submitCompetition,
                    child: const Text("Submit Competition"),
                    style: ElevatedButton.styleFrom(
                      shape:   RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
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
