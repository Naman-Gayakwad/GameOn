import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gameon/Mentor/Mentor%20Screen/main_mentor_screen.dart';
import 'package:gameon/Mentor/Mentor%20Screen/mentor%20registration/mentorregistration.dart';

class MantorLanding extends StatelessWidget {
  const MantorLanding({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference _mentorStream =
        FirebaseFirestore.instance.collection('mentors');
    return StreamBuilder<DocumentSnapshot>(
      stream: _mentorStream.doc(_auth.currentUser!.uid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        if (!snapshot.data!.exists) {
          return Mentorregistration();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final isVerified = data['isVerified'] as bool? ?? false;

        if (isVerified == true) {
          return MainMentorScreen();
        }

        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF9733EE),
                Color(0xFFB42CF5),
                Color(0xFFDA22FF),
                Color(0xFFEC90FF),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
                bottom: MediaQuery.of(context).size.height * 0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/mentor/documentverify.png'),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'We will get back to you soon after your document verification',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                      color: Colors.black
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
