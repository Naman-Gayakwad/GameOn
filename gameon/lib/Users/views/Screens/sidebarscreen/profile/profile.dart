import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userId;
  String? imageUrl;
  bool isMentor = false;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  DateTime? createdAt;
  String name = "";

  bool isLoading = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (!doc.exists) return;

    final data = doc.data()!;
    setState(() {
      name = data['name'] ?? '';
      emailController = TextEditingController(text: data['email'] ?? '');
      phoneController = TextEditingController(text: data['phone'] ?? '');
      imageUrl = data['userimage'];
      isMentor = data['mentor'] ?? false;
      createdAt = data['createdAt']?.toDate();
      isLoading = false;
    });
  }

  Future<void> uploadImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null && userId != null) {
      final ref = FirebaseStorage.instance.ref().child('user_images/$userId.jpg');
      await ref.putFile(File(picked.path));
      final newUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'userimage': newUrl,
      });

      setState(() {
        imageUrl = newUrl;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile picture updated!')),
      );
    }
  }

  Future<void> saveChanges() async {
    if (userId == null) return;

    setState(() => isSaving = true);

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
    });

    setState(() => isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(color: Colors.white
        )),
        backgroundColor: const Color(0xFFA32EEB),
        actions: [
          IconButton(
            onPressed: isSaving ? null : saveChanges,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: imageUrl == null ? uploadImage : null,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: imageUrl != null
                          ? NetworkImage(imageUrl!)
                          : null,
                      child: imageUrl == null
                          ? const Icon(Icons.add_a_photo, size: 30, color: Colors.white70)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  // Email
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      prefixIcon: const Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Phone
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: "Phone",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),

                  // Extra Info
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ProfileTile(icon: Icons.badge, title: "User Type", value: isMentor ? "Mentor" : "User"),
                          ProfileTile(
                            icon: Icons.calendar_today,
                            title: "Joined On",
                            value: createdAt != null ? createdAt.toString().split(' ').first : "Unknown",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFA32EEB)),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}
