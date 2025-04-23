import 'package:flutter/material.dart';
import 'package:gameon/Mentor/Mentor%20Screen/mantor_landing.dart';
import 'package:gameon/Users/views/Screens/coach/widgets/mentorlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoachScreen extends StatefulWidget {
  const CoachScreen({super.key});

  @override
  State<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {
  String selectedCategory = '';
  String selectedSport = '';

  @override
  void initState() {
    super.initState();
    _loadSavedSport();
  }

  Future<void> _loadSavedSport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isIndoor = prefs.getBool('isIndoor');
    String? sport = prefs.getString('selectedSport');

    setState(() {
      selectedCategory = isIndoor == true ? 'Indoor' : 'Outdoor';
      selectedSport = sport ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final ph = MediaQuery.of(context).size.height;
    final pw = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: ph * 0.025, right: pw * 0.14),
                child: Image.asset('assets/images/coach/line.png',
                    fit: BoxFit.fitWidth),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: ph * 0.02, left: pw * 0.07, right: pw * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1 on 1 Coach',
                          style: TextStyle(
                            fontSize: ph * 0.02,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: ph * 0.01),
                        Text(
                          'Book a session with\nqualified coach’s to\nbuild your career!',
                          style: TextStyle(
                            fontSize: ph * 0.02,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ph * 0.3,
                      width: pw * 0.4,
                      child: Image.asset('assets/images/coach/coach.png',
                          fit: BoxFit.contain),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: ph * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: pw * 0.45,
                height: ph * 0.07,
                decoration: BoxDecoration(
                  color: Color(0xff0F6DFB),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Find Coach',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: ph * 0.022,
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.search, color: Colors.white, size: ph * 0.03),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MantorLanding(),
                    ),
                  );
                },
                child: Container(
                  width: pw * 0.45,
                  height: ph * 0.07,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Be a Coach',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: ph * 0.022,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ph * 0.03),
          Mentorlist(selectedSport: selectedSport)
        ],
      ),
    );
  }
}
