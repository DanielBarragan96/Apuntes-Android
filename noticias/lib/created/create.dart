import 'package:flutter/material.dart';

class CreateNew extends StatefulWidget {
  CreateNew({Key key}) : super(key: key);

  @override
  _CreateNewState createState() => _CreateNewState();
}

//TODO formulario para crear noticias, permita fotos o galeria
class _CreateNewState extends State<CreateNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Crear noticia"),
      ),
    );
  }
}
