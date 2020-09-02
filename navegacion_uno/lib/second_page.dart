import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  final String dato;

  SecondPage({Key key, @required this.dato}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            children: [
              Text('Dato recibido: $dato'),
              TextField(
                controller: _controller,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(_controller.text);
                },
                child: Text("Guardar"),
                color: Colors.green[50],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
