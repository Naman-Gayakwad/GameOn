import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: const Color(0xffA32EEB),
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/drawer/aboutus.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Welcome to GameOn! We are dedicated to providing the best platform for sports enthusiasts. Our mission is to connect players, coaches, and fans through engaging content and community-driven experiences.',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Our team is passionate about sports and technology, and we strive to create a user-friendly experience for everyone. Thank you for being a part of our community!',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}