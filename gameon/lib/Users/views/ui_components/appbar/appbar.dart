import 'package:flutter/material.dart';
import 'package:gameon/Users/views/ui_components/bottom%20navigation/nav_appbar_screen.dart';

class customAppbar extends StatefulWidget {
  final Widget child;
  const customAppbar({super.key, required this.child});

  @override
  State<customAppbar> createState() => _customAppbarState();
}

class _customAppbarState extends State<customAppbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffA32EEB),
        leading: const IconButton(
          onPressed: null,
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
        actions: const [
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
      body: widget.child,
    );
  }
}