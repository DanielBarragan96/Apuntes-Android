import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class Confidential extends StatefulWidget {
  Confidential({Key key}) : super(key: key);

  @override
  _ConfidentialState createState() => _ConfidentialState();
}

class _ConfidentialState extends State<Confidential>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantalla Confidencial"),
      ),
      body: AnimatedBackground(
        child: Text("Cool!"),
        vsync: this,
        behaviour: BubblesBehaviour(),
      ),
    );
  }
}
