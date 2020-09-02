import 'package:flutter/material.dart';
import 'package:navegacion_uno/second_page.dart';
import 'package:navegacion_uno/third_page.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _datoDeSecondPage;

  String _datoDeThirdPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text("Dato 2 : ${_datoDeSecondPage ?? ""}"),
              Text("Dato 3 : ${_datoDeThirdPage ?? ""}"),
              MaterialButton(
                onPressed: () async {
                  _datoDeSecondPage = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SecondPage(dato: "hola"),
                    ),
                  );
                  setState(() {});
                },
                child: Text("Abrir page 2"),
                color: Colors.purple[50],
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => ThirdPage(numero: 898),
                    ),
                  )
                      .then((returnedValue) {
                    _datoDeThirdPage = returnedValue;
                    setState(() {});
                  });
                },
                child: Text("Abrir page 3"),
                color: Colors.yellow[50],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
