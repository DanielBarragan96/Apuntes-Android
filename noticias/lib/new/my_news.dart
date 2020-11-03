import 'package:flutter/material.dart';

class MyNews extends StatefulWidget {
  MyNews({Key key}) : super(key: key);

  @override
  _MyNewsState createState() => _MyNewsState();
}

//TODO
class _MyNewsState extends State<MyNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Mis noticias"),
      ),
    );
  }
}
