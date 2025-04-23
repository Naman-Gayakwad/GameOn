import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gameon/Mentor/controller/mentor_controller.dart';
import 'package:gameon/Mentor/widget/category_selector.dart';
import 'package:gameon/Mentor/widget/textformfield.dart';

class Mentorregistration extends StatefulWidget {
  const Mentorregistration({super.key});

  @override
  State<Mentorregistration> createState() => _MentorregistrationState();
}

class _MentorregistrationState extends State<Mentorregistration> {
  String? selectedFileName;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Mentorcontroller _mentorController = Mentorcontroller();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  String? selectedSport;
  Uint8List? certificateData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      final data = doc.data();
      if (data != null) {
        setState(() {
          nameController.text = data['name'] ?? '';
          emailController.text = data['email'] ?? '';
          phoneController.text = data['phone'] ?? '';
        });
      }
    }
  }

  selectmentorcertificate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      withData: true,
    );

    if (result != null) {
      File file = File(result.files.first.path!);
      Uint8List? fileData = await file.readAsBytes();
      String fileName = result.files.first.name;
      setState(() {
        selectedFileName = fileName;
        certificateData = fileData;
      });
    } else {
      print('No file selected');
    }
  }

  _saveMentordetails() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        specializationController.text.isEmpty ||
        selectedSport == null) {
      EasyLoading.showToast('Please fill all fields');
      return;
    }

    if (certificateData == null) {
      EasyLoading.showToast('Please upload your certificate');
      return;
    }

    EasyLoading.show();
    bool success = await _mentorController.registermentor(
      selectedSport!,
      nameController.text,
      emailController.text,
      phoneController.text,
      specializationController.text,
      certificateData!,
    );

    EasyLoading.dismiss();
    if (success) {
      EasyLoading.showToast('Mentor registered successfully');
    } else {
      EasyLoading.showToast('Failed to register mentor');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ph = MediaQuery.of(context).size.height;
    final pw = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: pw,
              maxHeight: ph,
            ),
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              fit: StackFit.loose,
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: pw * 0.15,
                  child: Image.asset(
                    'assets/images/mentor/rightside.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: ph * 0.25,
                  left: 0,
                  child: Image.asset(
                    'assets/images/mentor/leftside.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: ph,
                  width: pw,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: pw * 0.7,
                            width: pw * 0.42,
                            child: Image.asset(
                              'assets/images/mentor/mentor.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                'Be a Mentor & Guide\nwith GameOn Talent',
                                style: TextStyle(
                                  fontSize: ph * 0.025,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                                maxLines: 3,
                              ),
                              SizedBox(height: ph * 0.03),
                              Text(
                                'Fill in the details to continue\napplication',
                                style: TextStyle(
                                  fontSize: ph * 0.02,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                maxLines: 3,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: pw * 0.05,
                            bottom: ph * 0.01,
                          ),
                          child: Text(
                            'Choose your Category & Sport',
                            style: TextStyle(
                              fontSize: ph * 0.025,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      CategorySelector(
                        onSelectionChanged: (category, sport) {
                          setState(() {
                            selectedSport = sport;
                          });
                        },
                      ),
                      SizedBox(height: ph * 0.022),
                      CustomTextformfieldtwo(
                        hintText: 'Name',
                        controller: nameController,
                        icon: const Icon(Icons.account_circle_outlined),
                        showPasswordIcon: false,
                        maxlength: 100,
                        isSpecialCharacter: false,
                      ),
                      SizedBox(height: ph * 0.015),
                      CustomTextformfieldtwo(
                        hintText: 'Email',
                        controller: emailController,
                        icon: const Icon(Icons.email_outlined),
                        showPasswordIcon: false,
                        maxlength: 100,
                        isSpecialCharacter: false,
                      ),
                      SizedBox(height: ph * 0.015),
                      CustomTextformfieldtwo(
                        hintText: 'Phone Number',
                        controller: phoneController,
                        icon: const Icon(Icons.call),
                        showPasswordIcon: false,
                        maxlength: 10,
                        isSpecialCharacter: true,
                      ),
                      SizedBox(height: ph * 0.015),
                      CustomTextformfieldtwo(
                        hintText: 'Specialization',
                        controller: specializationController,
                        icon: const Icon(Icons.badge),
                        showPasswordIcon: false,
                        maxlength: 100,
                        isSpecialCharacter: false,
                      ),
                      SizedBox(height: ph * 0.015),
                      GestureDetector(
                        onTap: () {
                          selectmentorcertificate();
                        },
                        child: Container(
                          width: pw * 0.85,
                          height: ph * 0.07,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E9FF),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: pw * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.upload, color: Colors.black),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    selectedFileName ?? "Upload Your Certification",
                                    style: const TextStyle(color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                          left: pw * 0.05,
                          right: pw * 0.05,
                          bottom: ph * 0.03,
                        ),
                        child: InkWell(
                          onTap: () {
                            _saveMentordetails();
                          },
                          child: Container(
                            height: ph * 0.07,
                            width: pw * 0.67,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 218, 34, 255),
                                  Color.fromARGB(255, 151, 51, 238),
                                ],
                                stops: [0, 1],
                                begin: Alignment(0, -1),
                                end: Alignment(0, 1),
                              ),
                              borderRadius: BorderRadius.circular(60),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 6,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'Apply',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
