import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.blue,
        accentColor: Colors.green,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.red,
            fontSize: 42,
            fontWeight: FontWeight.w900,
          ),
          button: TextStyle(
            fontSize: 16,
          ),
          headline4: TextStyle(
            color: Colors.purple,
          ),
          headline6: TextStyle(
            color: Colors.grey,
          ),
        ),
        fontFamily: "Kufam",
        backgroundColor: Colors.teal,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
