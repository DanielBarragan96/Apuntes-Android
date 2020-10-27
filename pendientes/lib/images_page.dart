import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pendientes/constants.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({Key key}) : super(key: key);
  final String image64 = encodedImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Encoding base 64"),
        ),
        body: Container(
          height: 300,
          width: 300,
          child: Image.memory(base64Decode(image64)),
        ),
      ),
    );
  }
}
