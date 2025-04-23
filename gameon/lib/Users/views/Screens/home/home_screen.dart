import 'package:flutter/material.dart';
import 'package:gameon/Users/views/Screens/Category/sport_selector.dart';
import 'package:gameon/Users/views/Screens/home/widgets/Banner/banner_widget.dart';
import 'package:gameon/Users/views/Screens/home/widgets/custom%20container/custom_container.dart';
import 'package:gameon/Users/views/Screens/home/widgets/custom%20container/custom_container2.dart';
import 'package:gameon/Users/views/ui_components/bottom%20navigation/nav_appbar_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset('assets/images/home/homepageindex.png',
                  fit: BoxFit.fitWidth),
              Column(
                children: [
                  SportSelector(
                    onSelectionChanged: (type, sport) {},
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03),
                    child: const BannerWidget(),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const NavCard(
                title: 'History',
                image: 'assets/images/home/history.png',
                colors: <Color>[
                  Color(0xff9BFFAB),
                  Color.fromARGB(240, 198, 242, 205)
                ],
                stops: <double>[0, 0.479],
                begin: Alignment(0, -1),
                end: Alignment(0, 1),
                margin: null,
              ),
              NavCard(
                title: 'Learn &\nPractice',
                image: 'assets/images/home/practice.png',
                colors: const <Color>[
                  Color.fromARGB(255, 237, 226, 198),
                  Color(0xffffe39b)
                ],
                stops: const <double>[0.453, 1],
                begin: const Alignment(-0.009, -0.853),
                end: const Alignment(-0.009, 0.469),
                margin: null,
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainPage(tapIndex: 1)));
                },
              ),
              NavCard(
                title: 'Contest',
                image: 'assets/images/home/contest.png',
                colors: const <Color>[
                  Color.fromARGB(255, 252, 174, 174),
                  Color(0xffFC6F6F)
                ],
                stops: const <double>[0.354, 1],
                begin: const Alignment(-1, -0.853),
                end: const Alignment(0.009, 0.594),
                margin: const EdgeInsets.only(top: 10),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainPage(tapIndex: 2)));
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NavCard(
                title: 'Coach',
                image: 'assets/images/home/coach.png',
                colors: const <Color>[
                  Color(0xffB75BFF),
                  Color.fromARGB(255, 222, 179, 255)
                ],
                stops: const <double>[0, 0.62],
                begin: const Alignment(0.252, -0.483),
                end: const Alignment(-0.791, 0.916),
                margin: null,
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainPage(tapIndex: 3)));
                },
              ),
              NavCard(
                title: 'Store',
                image: 'assets/images/home/store.png',
                colors: const <Color>[Color(0xffFEB0B0), Color(0xffB0CBFE)],
                stops: const <double>[0.599, 1],
                begin: const Alignment(1.696, -1.434),
                end: const Alignment(0.261, 0.49),
                margin: null,
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainPage(tapIndex: 4)));
                },
              ),
              NavCard(
                title: 'News',
                image: 'assets/images/home/news.png',
                colors: const <Color>[
                  Color.fromARGB(255, 254, 174, 255),
                  Color.fromARGB(255, 252, 103, 255)
                ],
                stops: const <double>[0.354, 0.958],
                begin: const Alignment(0.774, 1),
                end: const Alignment(-0.313, -0.552),
                margin: null,
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainPage(tapIndex: 5)));
                },
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Explore Opportunities',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA32EEB)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.008,
                ),
                Text(
                  'Play, showcase skills and build your strong community through online or offline opportunities of your interest and make your mark !',
                  style: TextStyle(
                      color: const Color(0xFFA32EEB).withOpacity(0.8)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.008,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ExploreCard(
                        title: 'Under 16',
                        image: 'assets/images/home/under16.png'),
                    ExploreCard(
                        title: 'Under 19',
                        image: 'assets/images/home/under19.png'),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ExploreCard(
                        title: 'Under 23',
                        image: 'assets/images/home/under21.png'),
                    ExploreCard(
                        title: 'For Women',
                        image: 'assets/images/home/specialwomenfinal.png'),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
        ],
      ),
    );
  }
}
