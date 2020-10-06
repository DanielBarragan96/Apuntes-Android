import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_labeling_and_barcodes/login/login_page.dart';

import 'home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Practica integradora 2",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.grey[50],
      ),
      home: LoginPage(),
    );
  }
}
