import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
        actions: [
          IconButton(
            icon: Icon(Icons.accessibility),
            onPressed: () {
              //abrir second page
              Navigator.of(context).pushNamed("/secondPage");
            },
          ),
          IconButton(
            icon: Icon(Icons.adb),
            onPressed: () {
              //abrir profile
              Navigator.of(context).pushNamed("/profile");
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Nombre"),
              accountEmail: Text("correo@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: FlutterLogo(
                  size: 48,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24),
              child: Text("Navegacion"),
            ),
            ListTile(
              leading: Icon(Icons.add_call),
              title: Text("Second page"),
              onTap: () {
                Navigator.of(context).pop();
                return Navigator.of(context).pushNamed("/secondPage");
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text("Profile page"),
              onTap: () {
                Navigator.of(context).pop();
                return Navigator.of(context).pushNamed("/profile");
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
