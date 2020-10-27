import 'package:flutter/material.dart';
import 'package:pendientes/search_page.dart';
import 'package:url_launcher/url_launcher.dart';

import 'images_page.dart';
import 'text_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                child: Text("Busqueda"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                    ),
                  );
                },
              ),
              MaterialButton(
                child: Text("Llamada"),
                onPressed: () {
                  _launchPhone();
                },
              ),
              MaterialButton(
                child: Text("WhatsApp"),
                onPressed: () {
                  _launchWhatsApp();
                },
              ),
              MaterialButton(
                child: Text("Abrir link"),
                onPressed: () {
                  _launchUrl();
                },
              ),
              MaterialButton(
                child: Text("Img base 64"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImagePage(),
                    ),
                  );
                },
              ),
              MaterialButton(
                child: Text("Texto"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TextPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchWhatsApp() async {
    await launch("whatsapp://send?phone=523317865113");
  }

  _launchPhone() async {
    await launch("tel:3317865113");
  }

  _launchUrl() async {
    await launch("https://iteso.mx");
  }
}
