import 'package:flutter/material.dart';

import 'constants.dart';

class TextPage extends StatefulWidget {
  const TextPage({Key key}) : super(key: key);

  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  final String image64 = encodedImage;
  bool expandedText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Text page"),
        ),
        body: Row(
          children: [
            (expandedText)
                ? SingleChildScrollView(
                    child: Container(
                      width: 300,
                      child: Text(
                        image64,
                      ),
                    ),
                  )
                : Container(
                    width: 300,
                    child: Text(
                      image64,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
            IconButton(
                icon: Icon((expandedText)
                    ? Icons.arrow_circle_up
                    : Icons.arrow_circle_down),
                onPressed: () {
                  setState(() {
                    expandedText = !expandedText;
                  });
                })
          ],
        ),
      ),
    );
  }
}
