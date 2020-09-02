import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  final double numero;
  ThirdPage({Key key, @required this.numero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            children: [
              Text('Numero recibido: $numero'),
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
