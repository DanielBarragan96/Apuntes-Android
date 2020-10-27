import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_apunte.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apuntes"),
      ),
      body: BlocProvider<HomeBloc>(
        create: (context) {
          _homeBloc = HomeBloc()..add(GetDataEvent());
          return _homeBloc;
        },
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is DataRemovedState)
              _showMessage(context, "Se ha borrado un elemento");
            else if (state is DataSavedErrorState)
              _showMessage(context, "${state.errorMessage}");
            else if (state is DataSavedState)
              _showMessage(context, "Se ha guardado un elemento");
            else if (state is DataFetchingState)
              _showMessage(context, "Descargando datos");
          },
          builder: (context, state) {
            return ListView.builder(
              itemCount: _homeBloc.getApuntesList != null
                  ? _homeBloc.getApuntesList.length
                  : 0,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("${_homeBloc.getApuntesList[index].materia}"),
                  subtitle:
                      Text("${_homeBloc.getApuntesList[index].descripcion}"),
                  leading: CircleAvatar(
                    maxRadius: 30,
                    child: Image.network(
                      _homeBloc.getApuntesList[index].imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_forever),
                    onPressed: () {
                      _homeBloc.add(RemoveDataEvent(index: index));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: _homeBloc,
                child: AddApunte(),
              ),
            ),
          );
        },
        label: Text("Agregar"),
        icon: Icon(Icons.add_box),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text("$message"),
        ),
      );
  }
}
