import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Map<String, dynamic>> listaDeCarros;

  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetCarrosEvent) {
      try {
        await _getCarros();
        yield CarrosListState(misCarrosList: listaDeCarros);
      } catch (e) {
        yield UpdatedErrorState();
      }
    } else if (event is UpdateEvent) {
      try {
        await _updateCarros(event.elementId, event.newData);
        await _getCarros();
        yield UpdatedSuccessState();
        yield CarrosListState(misCarrosList: listaDeCarros);
      } catch (e) {
        yield UpdatedErrorState();
      }
    }
  }

  Future _updateCarros(String elementId, Map<String, dynamic> newData) async {
    var carrosReference = FirebaseFirestore.instance.collection("carros");
    carrosReference.doc(elementId).update(newData);
  }

  Future _getCarros() async {
    var misCarros = await FirebaseFirestore.instance.collection("carros").get();
    listaDeCarros = misCarros.docs
        .map(
          (e) => {
            "docId": e.id,
            "color": e["color"],
            "marca": e["marca"],
            "modelo": e["modelo"],
            "year": e["year"],
          },
        )
        .toList();
    print("Listo!");
  }
}
