import 'package:flutter/material.dart';
import 'package:noticias/models/noticia.dart';
import 'package:noticias/noticias/item_noticia.dart';

class NoticiaNegocio extends StatefulWidget {
  final List<Noticia> noticias;
  NoticiaNegocio({Key key, @required this.noticias}) : super(key: key);

  @override
  _NoticiaDeporteState createState() => _NoticiaDeporteState();
}

class _NoticiaDeporteState extends State<NoticiaNegocio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: widget.noticias.length,
          itemBuilder: (BuildContext context, int index) {
            return ItemNoticia(noticia: widget.noticias[index]);
          },
        ),
      ),
    );
  }
}
