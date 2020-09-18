import 'dart:io';

import 'package:authentication_local/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;
  File _choosenImage;
  TextEditingController _textEditingController = TextEditingController(
    text: "www.google.com",
  );

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 200,
              width: 200,
              child: Image.file(
                  _choosenImage == null ? Placeholder() : _choosenImage),
            ),
            MaterialButton(
              onPressed: () {},
              color: Colors.purple[100],
              child: Text("Cargar imagen"),
            ),
            TextField(
              controller: _textEditingController,
            ),
            MaterialButton(
              onPressed: () {},
              color: Colors.blue[100],
              child: Text("Cargar imagen"),
            ),
            MaterialButton(
              onPressed: () {},
              color: Colors.yellow[100],
              child: Text("Cargar imagen"),
            ),
          ],
        ),
      ),
    );
  }
}
