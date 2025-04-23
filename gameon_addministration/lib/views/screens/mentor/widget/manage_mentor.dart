import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gameon_addministration/views/screens/mentor/widget/viewpdf.dart';

class ManageMentor extends StatelessWidget {
  const ManageMentor({super.key});

  Widget mentorData(int? flex, Widget widget) {
    return Expanded(
      flex: flex!,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade700),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _mentorStream =
        FirebaseFirestore.instance.collection('mentors').snapshots();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return StreamBuilder<QuerySnapshot>(
      stream: _mentorStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final mentoruserData = snapshot.data!.docs[index];
            return Container(
              child: Row(
                children: [
                  mentorData(
                      2,
                      Text(
                        mentoruserData['name'],
                        style: TextStyle(fontSize: 16),
                      )),
                  mentorData(
                      3,
                      Text(
                        mentoruserData['email'],
                        style: TextStyle(fontSize: 16),
                      )),
                  mentorData(
                      2,
                      Text(
                        mentoruserData['phone'],
                        style: TextStyle(fontSize: 16),
                      )),
                  mentorData(
                      2,
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FirebasePDFViewer(
                                  pdfUrl: mentoruserData['certificateUrl'],
                                ),
                              ),
                            );
                          },
                          child: Text('View Certificate'))),
                  mentorData(
                      1,
                      mentoruserData['isVerified'] == false
                          ? ElevatedButton(
                              onPressed: () {
                                _firestore
                                    .collection('mentors')
                                    .doc(mentoruserData.id)
                                    .update({
                                  'isVerified': true,
                                });
                                _firestore
                                    .collection('users')
                                    .doc(mentoruserData.id)
                                    .update({
                                  'mentor': true,
                                });
                              },
                              child: Text('Approve'))
                          : ElevatedButton(
                              onPressed: () {
                                _firestore
                                    .collection('mentors')
                                    .doc(mentoruserData.id)
                                    .update({
                                  'isVerified': false,
                                });
                                _firestore
                                    .collection('users')
                                    .doc(mentoruserData.id)
                                    .update({
                                  'mentor': false,
                                });
                              },
                              child: Text('Reject'))),
                  mentorData(
                    1,
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('View More'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
