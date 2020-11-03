import 'package:flutter/material.dart';
import 'package:noticias/models/noticia.dart';

class ItemNoticia extends StatelessWidget {
  final Noticia noticia;

  ItemNoticia({Key key, @required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          child: Row(
            children: [
              //TODO Cambiar image network por placeholder en caso de error o mientras descarga la imagen
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: (noticia.urlToImage != null &&
                          noticia.urlToImage != "(none)")
                      ? Image.network(
                          "${noticia.urlToImage}",
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          color: Colors.indigo,
                        ),
                ),
              ),

              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${noticia.title ?? "No disponible"}",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${noticia.publishedAt ?? "No disponible"}",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "${noticia.description ?? "Descripción no disponible"}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "${noticia.author ?? "Autor no disponible"}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
