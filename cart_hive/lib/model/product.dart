import 'package:flutter/foundation.dart';

class Product {
  final String idProd;
  final String picture;
  final String name;
  final double price;
  final String descrip;
  final bool favorite;
  final int ranking;
  final int amount;

  Product({
    @required this.idProd,
    @required this.picture,
    @required this.name,
    @required this.price,
    this.descrip = "Producto en oferta",
    this.favorite = false,
    this.ranking = 5,
    this.amount = 1,
  });
}
