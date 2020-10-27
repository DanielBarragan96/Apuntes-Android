import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class AddApunte extends StatefulWidget {
  AddApunte({Key key}) : super(key: key);

  @override
  _AddApunteState createState() => _AddApunteState();
}

class _AddApunteState extends State<AddApunte> {
  File _choosenImage;
  String _url;
  bool _isLoading = false;
  TextEditingController _materiaController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar apunte")),
      body: BlocProvider(
        create: (context) {
          bloc = HomeBloc()..add(GetDataEvent());
          return bloc;
        },
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is ChosenImageFailedState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("No se puedo cargar la imagen."),
                  ),
                );
            } else if (state is FileUploadFailedState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("No se puedo subir la imagen al bucket."),
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state is ChosenImageLoaded) {
              _choosenImage = state.imgPath;
            }
            if (state is FileUploadedState) {
              _url = state.fileUrl;
              _saveData();
            }
            return _newApuntePage();
          },
        ),
      ),
    );
  }

  void _saveData() {
    BlocProvider.of<HomeBloc>(context).add(
      SaveDataEvent(
        materia: _materiaController.text,
        descripcion: _descripcionController.text,
        imageUrl: _url,
      ),
    );
    _isLoading = false;
    Future.delayed(Duration(milliseconds: 1500)).then((_) {
      Navigator.of(context).pop();
    });
  }

  Widget _newApuntePage() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Stack(
          alignment: FractionalOffset.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _choosenImage != null
                    ? Image.file(
                        _choosenImage,
                        width: 150,
                        height: 150,
                      )
                    : Container(
                        height: 150,
                        width: 150,
                        child: Placeholder(
                          fallbackHeight: 150,
                          fallbackWidth: 150,
                        ),
                      ),
                SizedBox(height: 48),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    bloc.add(ChooseImageEvent());
                  },
                ),
                SizedBox(height: 48),
                TextField(
                  controller: _materiaController,
                  decoration: InputDecoration(
                    hintText: "Nombre de la materia",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _descripcionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Notas para el examen...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text("Guardar"),
                        onPressed: () {
                          bloc.add(UploadFileEvent(file: _choosenImage));
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
            _isLoading ? CircularProgressIndicator() : Container(),
          ],
        ),
      ),
    );
  }
}
