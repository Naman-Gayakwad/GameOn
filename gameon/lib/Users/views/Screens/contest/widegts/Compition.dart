import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gameon/Users/views/Screens/contest/Other%20pages/competitiondetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Competition extends StatefulWidget {
  const Competition({super.key});

  @override
  State<Competition> createState() => _CompetitionState();
}

class _CompetitionState extends State<Competition> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<DocumentSnapshot> _competitionDocs = [];
  String selectedSport = '';
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _loadSavedSport();
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_competitionDocs.isEmpty) return;
      setState(() {
        _currentPage = (_currentPage + 1) % _competitionDocs.length;
      });

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> _loadSavedSport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sport = prefs.getString('selectedSport');

    setState(() {
      selectedSport = sport ?? '';
    });

    _loadCompetitions();
  }

  Future<void> _loadCompetitions() async {
    if (selectedSport.isEmpty) return;

    final querySnapshot = await _firestore
        .collection('competitions')
        .where('sport', isEqualTo: selectedSport)
        .where('approved', isEqualTo: true)
        .get();

    setState(() {
      _competitionDocs = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double bannerHeight = MediaQuery.of(context).size.height * 0.17;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: _competitionDocs.isEmpty
          ? const Center(child: Text("No competitions found"))
          : Container(
              height: bannerHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffB0CBFE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: _competitionDocs.length,
                    itemBuilder: (context, index) {
                      final competition = _competitionDocs[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          competition['bannerUrl'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.02,
                        bottom: MediaQuery.of(context).size.height * 0.006,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          final competitionData = _competitionDocs[_currentPage]
                              .data() as Map<String, dynamic>;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Competitiondetail(
                                competitionData: competitionData,
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.black),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        child: Text(
                          'Apply Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
