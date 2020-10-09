import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'product.g.dart';

//To generate product.g.dart use command:
//flutter packages pub run build_runner build
@HiveType(typeId: 1, adapterName: "CarritoAdapter")
class Product {
  @HiveType(typeId: 0)
  final String idProd;
  @HiveType(typeId: 1)
  final String picture;
  @HiveType(typeId: 2)
  final String name;
  @HiveType(typeId: 3)
  final double price;
  @HiveType(typeId: 4)
  final String descrip;
  @HiveType(typeId: 5)
  final bool favorite;
  @HiveType(typeId: 6)
  final int ranking;
  @HiveType(typeId: 7)
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
