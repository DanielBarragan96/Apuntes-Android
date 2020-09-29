import 'dart:io';

import 'package:autenticacion_local/bloc/home_bloc.dart';
import 'package:autenticacion_local/confidential.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  File choosenImage;
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
      body: SingleChildScrollView(
        child: Center(
          child: BlocProvider(
            create: (context) {
              _homeBloc = HomeBloc();
              return _homeBloc;
            },
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is AuthenticationErrorState) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Error!!"),
                      content: Text(state.message),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Aceptar"),
                        ),
                      ],
                    ),
                  );
                } else if (state is AuthenticationDoneState) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Confidential(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is LoadedImageState) return homeBody(state.image);

                return homeBody(choosenImage);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget homeBody(File _choosenImage) {
    choosenImage = _choosenImage;
    return Column(
      children: [
        Container(
          child:
              _choosenImage == null ? Placeholder() : Image.file(_choosenImage),
          height: 200,
          width: 200,
        ),
        MaterialButton(
          onPressed: () {
            _homeBloc.add(LoadImageEvent());
          },
          color: Colors.purple[100],
          child: Text("Cargar imagen"),
        ),
        TextField(
          controller: _textEditingController,
        ),
        MaterialButton(
          onPressed: () {},
          color: Colors.blue[100],
          child: Text("Ir al link"),
        ),
        MaterialButton(
          onPressed: () {
            _homeBloc.add(AuthenticationEvent());
          },
          color: Colors.yellow[100],
          child: Text("Desbloquear"),
        ),
      ],
    );
  }
}
