import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/noticias_bloc.dart';
import 'noticia_deportes.dart';
import 'noticia_negocios.dart';

class Noticias extends StatefulWidget {
  Noticias({Key key}) : super(key: key);

  @override
  _NoticiasState createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  final _tabsList = [
    Tab(icon: Icon(Icons.article), text: "Deportes"),
    Tab(icon: Icon(Icons.article), text: "Negocios"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Noticias'),
          bottom: TabBar(
            tabs: _tabsList,
          ),
        ),
        body: BlocProvider(
          create: (context) => NoticiasBloc()..add(GetNewsEvent()),
          child: BlocConsumer<NoticiasBloc, NoticiasState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is NoticiasSucessState) {
                return TabBarView(
                  children: [
                    NoticiaDeporte(noticias: state.noticiasSportList),
                    NoticiaNegocio(noticias: state.noticiasBusinessList),
                  ],
                );
              }
              return Center(child: Text("No hay noticias disponibles"));
            },
          ),
        ),
      ),
    );
  }
}
