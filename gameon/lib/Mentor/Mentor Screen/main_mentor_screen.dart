import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gameon/Mentor/widget/uploadimage.dart';
import 'package:gameon/Users/views/ui_components/appbar/appbar.dart';
import 'package:image_picker/image_picker.dart';

class MainMentorScreen extends StatefulWidget {
  const MainMentorScreen({super.key});

  @override
  State<MainMentorScreen> createState() => _MainMentorScreenState();
}

class _MainMentorScreenState extends State<MainMentorScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List imageData = await image.readAsBytes();
      return imageData;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ph = MediaQuery.of(context).size.height;
    final pw = MediaQuery.of(context).size.width;

    return FutureBuilder<DocumentSnapshot>(
      future:
          _firestore.collection('mentors').doc(_auth.currentUser?.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final userDoc = snapshot.data!;

        return customAppbar(
          child: Column(
            children: [
              Container(
                height: ph * 0.2,
                width: pw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF6385FF),
                      const Color(0xFFDA22FF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    right: pw * 0.05,
                    top: ph * 0.03,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: pw * 0.05,
                        ),
                        height: ph * 0.08,
                        width: pw * 0.16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: userDoc['image'] != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.network(
                                  userDoc['image']!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  _pickImage().then((image) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Uploadimage(
                                          image: image,
                                        ),
                                      ),
                                    );
                                  });
                                },
                                icon: Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 50,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                      SizedBox(
                        width: pw * 0.08,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            userDoc['name'] ?? 'Mentor Name',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: ph * 0.016,
                          ),
                          Text(
                            'Specilization: ${userDoc['sport'] ?? 'Sport'}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
