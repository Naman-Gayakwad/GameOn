import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Mentorlist extends StatefulWidget {
  final String? selectedSport;
  Mentorlist({super.key, required this.selectedSport});

  @override
  State<Mentorlist> createState() => _MentorlistState();
}

class _MentorlistState extends State<Mentorlist> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _mentorStream =
        FirebaseFirestore.instance.collection('mentors').snapshots();

    final ph = MediaQuery.of(context).size.height;
    final pw = MediaQuery.of(context).size.width;

    return StreamBuilder<QuerySnapshot>(
      stream: _mentorStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting ||
            widget.selectedSport!.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        final filteredMentors = snapshot.data!.docs.where((doc) {
          return doc['sport']?.toString().toLowerCase() ==
                  widget.selectedSport?.toLowerCase() &&
              doc['isVerified'] == true;
        }).toList();

        return filteredMentors.isEmpty
            ? Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/mentor/findmentor.png',
                        height: ph * 0.26, width: pw * 0.8),
                    Text(
                      'No mentors found for "$widget.selectedSport"\nwe will get one soon!',
                      style: TextStyle(fontSize: ph * 0.02),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredMentors.length,
                itemBuilder: (context, index) {
                  final mentoruserData = filteredMentors[index];
                  return Container(
                    margin: EdgeInsets.only(
                      left: pw * 0.04,
                      right: pw * 0.04,
                      top: ph * 0.02,
                    ),
                    height: ph * 0.18,
                    width: pw * 0.8,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 215, 242, 255),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: pw * 0.04,
                            top: ph * 0.024,
                          ),
                          height: ph * 0.08,
                          width: pw * 0.16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: mentoruserData['image'] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.network(
                                    mentoruserData['image']!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(Icons.person,
                                  size: 40, color: Colors.white),
                        ),
                        SizedBox(width: pw * 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              mentoruserData['name'] ?? 'Mentor Name',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${mentoruserData['sport']} course for Beginner',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: pw * 0.3,
                                  height: ph * 0.05,
                                  decoration: BoxDecoration(
                                    color: Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Buy Course',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: ph * 0.016,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: pw * 0.03),
                                Container(
                                  width: pw * 0.34,
                                  height: ph * 0.05,
                                  decoration: BoxDecoration(
                                    color: Color(0xff6385FF),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Book a live lesson',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: ph * 0.016,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
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
