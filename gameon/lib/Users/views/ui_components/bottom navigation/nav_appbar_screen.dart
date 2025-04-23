import 'package:flutter/material.dart';
import 'package:gameon/Users/views/Screens/coach/coach_screen.dart';
import 'package:gameon/Users/views/Screens/contest/contest_screen.dart';
import 'package:gameon/Users/views/Screens/home/home_screen.dart';
import 'package:gameon/Users/views/Screens/learn%20and%20practice/learn&practicescreen.dart';
import 'package:gameon/Users/views/Screens/news/news_screen.dart';
import 'package:gameon/Users/views/Screens/store/store_screen.dart';
import 'package:gameon/Users/views/ui_components/side%20bar%20drawer/sidebardrawer.dart';

class MainPage extends StatefulWidget {
  final int? tapIndex;
  MainPage({super.key, this.tapIndex});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  final List<Widget> _children = const [
    HomeScreen(),
    LearnAndPracticeScreen(),
    ContestScreen(),
    CoachScreen(),
    StoreScreen(),
    NewsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.tapIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: Sidebardrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xffA32EEB),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(
            Icons.account_circle_outlined,
            size: 35,
            color: Colors.black,
          ),
        ),
        leadingWidth: MediaQuery.of(context).size.width * 0.11,
        title: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          },
          child: Text(
            'GameOn!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions:  [
          // IconButton(
          //   onPressed: null,
          //   icon: Icon(
          //     Icons.search,
          //     size: 35,
          //     color: Colors.black,
          //   ),
          // ),
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.notifications_none,
              size: 35,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: _currentIndex == 0 ? 25 : 20,
              child: Icon(
                _currentIndex == 0 ? Icons.home : Icons.home_outlined,
                size: _currentIndex == 0 ? 35 : 30,
                color: _currentIndex == 0 ? Colors.purple : Colors.blueGrey,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: _currentIndex == 1 ? 25 : 20,
              child: Icon(
                _currentIndex == 1 ? Icons.school : Icons.school_outlined,
                size: _currentIndex == 1 ? 35 : 30,
                color: _currentIndex == 1 ? Colors.purple : Colors.blueGrey,
              ),
            ),
            label: 'Learn & Practice',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: _currentIndex == 2 ? 25 : 20,
              child: Icon(
                _currentIndex == 2
                    ? Icons.emoji_events
                    : Icons.emoji_events_outlined,
                size: _currentIndex == 2 ? 35 : 30,
                color: _currentIndex == 2 ? Colors.purple : Colors.blueGrey,
              ),
            ),
            label: 'Contest',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: _currentIndex == 3 ? 25 : 20,
              child: Icon(
                _currentIndex == 3 ? Icons.sports : Icons.sports,
                size: _currentIndex == 3 ? 35 : 30,
                color: _currentIndex == 3 ? Colors.purple : Colors.blueGrey,
              ),
            ),
            label: 'Coach',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: _currentIndex == 4 ? 25 : 20,
              child: Icon(
                _currentIndex == 4 ? Icons.store : Icons.store_outlined,
                size: _currentIndex == 4 ? 35 : 30,
                color: _currentIndex == 4 ? Colors.purple : Colors.blueGrey,
              ),
            ),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: _currentIndex == 5 ? 25 : 20,
              child: Icon(
                _currentIndex == 5 ? Icons.article : Icons.article_outlined,
                size: _currentIndex == 5 ? 35 : 30,
                color: _currentIndex == 5 ? Colors.purple : Colors.blueGrey,
              ),
            ),
            label: 'News',
          ),
        ],
      ),
    );
  }
}
