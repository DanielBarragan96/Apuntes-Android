import 'dart:async'; // streams
import 'dart:convert'; // simple decode json
import 'dart:io'; // HttpStatus

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'; // simple http request

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final String _userDataLink = "https://jsonplaceholder.typicode.com/users/";
  StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    // initial state
    super.initState();
    // Connectivity README example
    _subscription = Connectivity().onConnectivityChanged.listen(
      (connectivityResult) {
        print("Connectivity: $connectivityResult");
        switch (connectivityResult) {
          case ConnectivityResult.wifi:
          case ConnectivityResult.mobile:
            _isThereConnectivity(true);
            break;
          case ConnectivityResult.none:
            _isThereConnectivity(false);
            break;
          default:
        }
      },
    );
  }

  void _isThereConnectivity(bool param0) {
    if (param0) {
      setState(() {}); // refresh state to repaint screen
      print("Refreshed UI...");
    } else
      _scaffoldKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text("There is no network connectivity..."),
          ),
        );
  }

  @override
  void dispose() {
    // dispose
    _subscription.cancel(); // close stream to avoid memory leaks
    super.dispose();
  }

  // HTTP GET method
  Future _getUserData() async {
    Response response = await get(_userDataLink);
    if (response.statusCode == HttpStatus.ok) {
      var result = jsonDecode(response.body);
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Streams',
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Connectivity stream'),
        ),
        body: FutureBuilder(
          future: _getUserData(),
          builder: (context, result) {
            if (result.hasData) {
              return ListView.builder(
                itemCount: (result.data as List).length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(result.data[index]["name"]),
                      subtitle: Text(result.data[index]["phone"]),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 24),
                    Text("Trying to get data"),
                    SizedBox(height: 24),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
