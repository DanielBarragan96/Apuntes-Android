import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cart_hive/model/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Box _carritoBox = Hive.box("Carrito");

  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is AddToCartEvent) {
      // TODO: guardar productos en carrito local
      _carritoBox.add(event.product);
      yield ElementAddedState();
    }
  }
}
