import 'package:flutter/material.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();
  bool _isActive = true;
  bool _isSeen = true;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi app'),
        backgroundColor: Colors.black54,
        actions: [
          IconButton(
            icon: Icon(
              Icons.done_all,
              color: _isSeen ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isSeen = !_isSeen;
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Text(
              "Mi primer App",
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 14),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Ingrese texto",
                  prefix: Icon(Icons.accessibility_new),
                ),
                maxLength: 12,
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    print("Texto : ${_textController.text}");
                    _textController.text = "";
                  },
                  child: Text("Mostrar"),
                  color: Colors.amber[100],
                ),
                MaterialButton(
                  onPressed: () {
                    _textController.clear();
                  },
                  child: Text("Borrar"),
                  color: Colors.deepPurple[100],
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dificil"),
                Switch(
                    value: _isActive,
                    onChanged: (newVal) {
                      setState(() {
                        _isActive = newVal;
                      });
                    }),
                Text("Facil"),
              ],
            ),
            SizedBox(height: 24),
            Image.network(
                "https://bucket3.glanacion.com/anexos/fotos/38/3089038.jpg")
          ],
        ),
      ),
    );
  }
}
