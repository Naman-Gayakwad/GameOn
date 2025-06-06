import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gameon_addministration/views/nav_screen.dart';

// void main() {
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid 
    ? FirebaseOptions(
      apiKey: "AIzaSyDvH4mDhdlBmzYd_AEPKupjaTQHCsVzKY4", 
      appId: "1:1014074674834:web:629576e72315c506c0a04b",
      messagingSenderId: "1014074674834", 
      projectId: "gameon-d02e1",
      storageBucket: "gameon-d02e1.appspot.com",)
      : null
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}
