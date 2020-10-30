import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:noticias/models/noticia.dart';

import '../../secrets.dart';

part 'noticias_event.dart';
part 'noticias_state.dart';

class NoticiasBloc extends Bloc<NoticiasEvent, NoticiasState> {
  final _sportsLink =
      'http://newsapi.org/v2/top-headlines?country=mx&category=sports&$API_KEY';
  final _businessLink =
      'http://newsapi.org/v2/top-headlines?country=mx&category=business&$API_KEY';

  NoticiasBloc() : super(NoticiasInitialState());

  @override
  Stream<NoticiasState> mapEventToState(
    NoticiasEvent event,
  ) async* {
    if (event is GetNewsEvent) {
      //request y deserializar json to dart y pasar a lista al estado
      try {
        List<Noticia> sportsNews = await _requestSportsNoticias();
        List<Noticia> businessNews = await _requestBusinessNoticias();
        yield NoticiasSucessState(
          noticiasSportList: sportsNews,
          noticiasBusinessList: businessNews,
        );
      } catch (e) {
        yield NoticiasErrorState(msg: "Error cargando noticias");
      }
    }
  }

  Future<List<Noticia>> _requestSportsNoticias() async {
    List<Noticia> _noticiasList = List();
    try {
      Response response = await get(_sportsLink);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)["articles"];
        _noticiasList =
            (data.map((element) => Noticia.fromJson(element))).toList();
      }
    } catch (error) {}
    return _noticiasList;
  }

  Future<List<Noticia>> _requestBusinessNoticias() async {
    List<Noticia> _noticiasList = List();
    try {
      Response response = await get(_businessLink);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)["articles"];
        _noticiasList =
            (data.map((element) => Noticia.fromJson(element))).toList();
      }
    } catch (error) {}
    return _noticiasList;
  }
}
