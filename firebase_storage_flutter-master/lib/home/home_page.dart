import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_apunte.dart';
import 'bloc/home_bloc.dart';
import 'item_apuntes.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc bloc;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apuntes"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: UniqueKey(),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: bloc,
                child: AddApunte(),
              ),
            ),
          );
        },
        label: Text("Agregar"),
        icon: Icon(Icons.add_box),
      ),
      body: BlocProvider(
        create: (context) {
          bloc = HomeBloc()..add(GetDataEvent());
          return bloc;
        },
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is CloudStoreRemoved) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Se ha eliminado el elemento."),
                  ),
                );
            } else if (state is CloudStoreError) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("${state.errorMessage}"),
                  ),
                );
            } else if (state is CloudStoreSaved) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Se ha guardado el elemento."),
                  ),
                );
              bloc.add(GetDataEvent());
            } else if (state is CloudStoreGetData) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Descargando datos..."),
                  ),
                );
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              // TODO: modify list elements to be shown
              return ListView.builder(
                itemCount: null ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return Container();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
