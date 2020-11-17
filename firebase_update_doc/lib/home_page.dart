import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc()..add(GetCarrosEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is UpdatedErrorState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Error!"),
                  ),
                );
            }
            if (state is UpdatedSuccessState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Hecho!"),
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state is CarrosListState) {
              return ListView.builder(
                itemCount: state.misCarrosList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Text(
                      "Elemento: ${state.misCarrosList[index]["marca"]}",
                    ),
                    onTap: () {
                      BlocProvider.of<HomeBloc>(context).add(
                        UpdateEvent(
                          newData: {
                            "color": "Rojo",
                            "year": "2020",
                          },
                          elementId: state.misCarrosList[index]["docId"],
                        ),
                      );
                    },
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
