import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Managelocalcompetitions extends StatelessWidget {
  const Managelocalcompetitions({super.key});

  Widget localcompetitiondata(int? flex, Widget widget) {
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
  String formatDate(DateTime? date) {
  if (date == null) return '';
  return DateFormat('yyyy-MM-dd').format(date);
}

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _localcompetitionsStream =
        FirebaseFirestore.instance.collection('competitions').snapshots();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return StreamBuilder<QuerySnapshot>(
      stream: _localcompetitionsStream,
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
            final localcompetitionsdata = snapshot.data!.docs[index];
            return Container(
              child: Row(
                children: [
                  localcompetitiondata(
                      2,
                      Text(
                        localcompetitionsdata['name'],
                        style: TextStyle(fontSize: 16),
                      )),
                  localcompetitiondata(
                      3,
                      Text(
                        localcompetitionsdata['description'],
                        style: TextStyle(fontSize: 16),
                      )),
                  localcompetitiondata(
                      1,
                      localcompetitionsdata['isPaid'] == true
                          ? Text(
                              'Paid',
                              style: TextStyle(fontSize: 16),
                            )
                          : Text(
                              'Free',
                              style: TextStyle(fontSize: 16),
                            )),
                  localcompetitiondata(
                      1,
                      Text(
                        formatDate(localcompetitionsdata['eventDate'].toDate()),
                        style: TextStyle(fontSize: 16),
                      )),
                  localcompetitiondata(
                      1,
                      Text(
                        formatDate(localcompetitionsdata['endDate'].toDate()),
                        style: TextStyle(fontSize: 16),
                      )),
                  localcompetitiondata(
                      1,
                      Text(
                        localcompetitionsdata['venue'].toString(),
                        style: TextStyle(fontSize: 16),
                      )),
                  localcompetitiondata(
                    1,
                    localcompetitionsdata['approved'] == false
                        ? ElevatedButton(
                            onPressed: () {
                              _firestore
                                  .collection('competitions')
                                  .doc(localcompetitionsdata.id)
                                  .update({
                                'approved': true,
                              });
                            },
                            child: Text('Approve'))
                        : Text(
                            'Approved',
                            style: TextStyle(
                              fontSize: 16,
                            ),
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
