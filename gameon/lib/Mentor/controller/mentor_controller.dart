import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Mentorcontroller {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  _uploadcertificate(Uint8List? certificate) async {
    Reference ref = _storage
        .ref()
        .child('mentorscertificate')
        .child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(certificate!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<bool> registermentor(
    String sport,
    String name,
    String email,
    String phone,
    String specialization,
    Uint8List certificate,
  ) async {
    try {
      String? certificateUrl = await _uploadcertificate(certificate);
      if (certificateUrl == null) throw Exception('Upload failed');

      await _firestore.collection('mentors').doc(_auth.currentUser!.uid).set({
        'sport': sport,
        'name': name,
        'email': email,
        'phone': phone,
        'specialization': specialization,
        'certificateUrl': certificateUrl,
        'image': null,
        'isVerified': false,
        'uid': _auth.currentUser!.uid,
        
      });

      return true;
    } catch (e) {
      print('Error registering mentor: $e');
      return false;
    }
  }
}
