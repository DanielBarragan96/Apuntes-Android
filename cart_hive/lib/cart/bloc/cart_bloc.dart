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
  List<Product> _productList = List();

  CartBloc() : super(CartInitial());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    // TODO: cargar productos
    if (event is LoadProductsEvent) {
      try {
        for (var i = 0; i < _carritoBox.length; i++) {
          Product aux = _carritoBox.getAt(i) as Product;
          if (aux != null) {
            _productList.add(aux);
          }
        }
        yield ElementsLoadedState(prodsList: _productList);
      } catch (e) {
        yield ElementsLoadedState(prodsList: _productList);
      }
    } else if (event is RemoveProductEvent) {
      _productList.removeAt(event.element);
      _carritoBox.deleteAt(event.element);
      if (_productList.isEmpty) {
        yield CartInitial();
      } else {
        yield ElementsLoadedState(prodsList: _productList);
      }
    }
  }
}
