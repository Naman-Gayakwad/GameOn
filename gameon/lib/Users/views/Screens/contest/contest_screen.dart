import 'package:flutter/material.dart';
import 'package:gameon/Users/views/Screens/contest/widegts/Compition.dart';
import 'package:gameon/Users/views/Screens/contest/widegts/hostcompetition.dart';
import 'package:gameon/Users/views/Screens/contest/widegts/nationalcompetition.dart';

class ContestScreen extends StatelessWidget {
  const ContestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ph = MediaQuery.of(context).size.height;
    final pw = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: pw * 0.055,
                  right: pw * 0.055,
                  top: ph * 0.02,
                  bottom: ph * 0.01),
              child: Text(
                'Competition, Fests, & more!',
                style: TextStyle(
                  fontSize: ph * 0.041,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff0F1598),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: pw * 0.0555, right: pw * 0.055, bottom: ph * 0.01),
              child: Container(
                width: pw * 0.55,
                height: ph * 0.004,
                decoration: BoxDecoration(
                  color: Color(0xffffbf5f),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: pw * 0.055,
                right: pw * 0.055,
                bottom: ph * 0.038,
              ),
              child: Text(
                'Participate in various opportunities to showcase your skills & get rewarded!',
                style: TextStyle(
                  fontSize: ph * 0.022,
                  color: Color(0xff004596),
                ),
              ),
            ),
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
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Explore Now',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: ph * 0.022,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  HostCompetition(),
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
                        'Host opportunity',
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
            Padding(
              padding: EdgeInsets.only(
                left: pw * 0.038,
                right: pw * 0.038,
                top: ph * 0.03,
                bottom: ph * 0.001,
              ),
              child: Text(
                'National level competition ',
                style: TextStyle(
                  fontSize: ph * 0.026,
                  color: Color(0xff9400D9),
                ),
              ),
            ),
            Nationalcompetition(),
            Padding(
              padding: EdgeInsets.only(
                left: pw * 0.038,
                right: pw * 0.038,
                top: ph * 0.01,
                bottom: ph * 0.001,
              ),
              child: Text(
                'Competition Near you  ',
                style: TextStyle(
                  fontSize: ph * 0.026,
                  color: Color(0xff9400D9),
                ),
              ),
            ),
            Competition(),
          ],
        ),
      ),
    );
  }
}
