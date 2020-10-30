import 'package:flutter/material.dart';
import 'package:noticias/models/noticia.dart';

class NoticiaDeporte extends StatefulWidget {
  final List<Noticia> noticias;
  NoticiaDeporte({Key key, @required this.noticias}) : super(key: key);

  @override
  _NoticiaDeporteState createState() => _NoticiaDeporteState();
}

class _NoticiaDeporteState extends State<NoticiaDeporte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Deportes: ${widget.noticias}"),
        ),
      ),
    );
  }
}
