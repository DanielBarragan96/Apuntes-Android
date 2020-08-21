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

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //la siguiente  var da accesp a contexto de Scaffle
    var _scaffoldkey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              _scaffoldkey.currentState
                //para esconder el snackbar actual
                ..hideCurrentSnackBar()
                //mostrar dialogo
                ..showSnackBar(SnackBar(
                  content: Text("Snackbar mostrar"),
                  duration: Duration(milliseconds: 300),
                ));
            },
            child: Text("Snackbar"),
            color: Colors.blue[100],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //mostrar dialogo
          showDialog(
              barrierDismissible:
                  //para que no se pueda quitar el mensaje
                  //al presionar fuera de este = false
                  //ESTO ES MALA PRACTICA
                  false,
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("Dialogo"),
                  content: Text("Contenido del texto"),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        //para salir del dialogo
                        Navigator.of(context).pop();
                      },
                      child: Text("Aceptar"),
                    )
                  ],
                );
              });
        },
        child: Icon(Icons.adjust),
        tooltip: "Dialogo",
      ),
    );
  }
}
