import 'package:flutter/material.dart';
import 'package:hive_example/home/home_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

void main() async {
  // inicializar antes de crear la app
  WidgetsFlutterBinding.ensureInitialized();
  // acceso al local storage
  final _localStorage = await path_provider.getApplicationDocumentsDirectory();
  // inicializar hive
  Hive.init(_localStorage.path);
  // abrir box
  await Hive.openBox("configuraciones");
  // crear app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: HomePage());
  }
}
