import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cart_hive/model/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../model/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  Box _carritoBox = Hive.box("Carrito");

  CartBloc() : super(CartInitial());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    // TODO: cargar productos
    if (event is LoadProductsEvent) {
      List<Product> _productList = List();
      for (var i = 0; i < _carritoBox.length; i++) {
        _productList.add(_carritoBox.get(i) as Product);
      }
      yield ElementsLoadedState(prodsList: _productList);
    }
  }
}
