import 'package:flutter/material.dart';
import 'package:gameon/Users/views/Screens/learn%20and%20practice/custom%20container/custom_containerl1.dart';
import 'package:gameon/Users/views/Screens/learn%20and%20practice/custom%20container/custom_containerl2.dart';

class LearnAndPracticeScreen extends StatelessWidget {
  const LearnAndPracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ph = MediaQuery.of(context).size.height;
    final pw = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Navcard2(
                title: 'Learn',
                image: 'assets/images/learn/learn.png',
                colors: <Color>[
                  Color.fromARGB(255, 200, 251, 255), // 43% opacity
                  Color.fromARGB(255, 80, 235, 255), // 43% opacity
                ],
                stops: <double>[0.35, 0.96],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                margin: null,
              ),
              Navcard2(
                title: 'Practice',
                image: 'assets/images/learn/practice.png',
                colors: <Color>[
                  Color.fromARGB(255, 254, 188, 255),
                  Color.fromARGB(255, 253, 108, 255),
                ],
                stops: <double>[0.35, 0.96],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                margin: null,
              ),
            ],
          ),
          SizedBox(
            height: ph * 0.04,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Circulercard(
                  title: 'Live lesson',
                  image: 'assets/images/learn/live.png',
                  colors: <Color>[
                    Color.fromRGBO(251, 205, 205, 1),
                    Color.fromARGB(255, 255, 134, 134),
                  ],
                  stops: <double>[-1, 0.6],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topLeft,
                ),
                Circulercard(
                  title: 'Live Match',
                  image: 'assets/images/learn/match.png',
                  colors: <Color>[
                    Color.fromARGB(255, 255, 200, 246),
                    Color.fromARGB(255, 117, 149, 231),
                  ],
                  stops: <double>[0, 0.8],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                Circulercard(
                  title: 'Practice with computer',
                  image: 'assets/images/learn/aipractice.png',
                  colors: <Color>[
                    Color.fromARGB(255, 243, 193, 193),
                    Color.fromARGB(255, 224, 124, 225),
                  ],
                  stops: <double>[0, 1],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                Circulercard(
                  title: 'Practice with computer',
                  image: 'assets/images/learn/aipractice.png',
                  colors: <Color>[
                    Color.fromARGB(255, 216, 255, 247),
                    Color.fromARGB(255, 151, 255, 141),
                  ],
                  stops: <double>[0, 1],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(pw * 0.035),
            child: Container(
              height: ph * 0.23,
              width: pw,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 206, 153, 253),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/learn/live2.png',
                            height: ph * 0.1,
                            width: pw * 0.2,
                          ),
                          Text(
                            textAlign: TextAlign.left,
                            'Live Match',
                            style: TextStyle(

                              fontSize: ph * 0.028,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ph * 0.01,
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        'Live class with\ntop players',
                        style: TextStyle(
                          fontSize: ph * 0.022,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.all(pw * 0.03),
                    child: Image.asset(
                      'assets/images/learn/chess.png',
                      height: ph * 0.23,
                      width: pw * 0.33,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
