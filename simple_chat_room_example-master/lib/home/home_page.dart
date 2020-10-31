import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User _user;
  User _user2;
  DatabaseReference _firebaseDatabase;
  final _textController = TextEditingController();

  @override
  void initState() {
    dynamic _now = DateTime.now().toUtc();
    _user = FirebaseAuth.instance.currentUser;
    _user2 = _user;
    _firebaseDatabase = FirebaseDatabase.instance
        .reference()
        .child("profiles/${_user.uid}/chats/${_user2.uid}/messages");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chateando"),
      ),
      body: Center(
        child: Column(
          children: [
            _messageList(),
            _composeMessage(),
          ],
        ),
      ),
    );
  }

  _messageList() {
    //construir lista de mensajes del chat
    return Flexible(
      child: FirebaseAnimatedList(
        query: _firebaseDatabase,
        // sort: (a, b) => b.key.compareTo(a.key),
        reverse: false,
        itemBuilder: (context, resultado, animation, index) {
          return _messageFromData(resultado, animation);
        },
      ),
    );
  }

  _messageFromData(DataSnapshot resultado, Animation<double> animation) {
    final String senderName = resultado.value["senderName"] ?? "Desconocido";
    final String msgTxt = resultado.value["text"] ?? "--";
    final int sentTime = resultado.value["timestamp"] ?? 0;
    // final String senderPhotoUrl = resultado.value["senderPhotoUrl"];

    return Padding(
      padding: EdgeInsets.all(24),
      child: Row(
        children: [
          CircleAvatar(
            child: Text(senderName[0]),
          ),
          Column(
            children: [
              Text(senderName, style: Theme.of(context).textTheme.subtitle1),
              Text(DateTime.fromMillisecondsSinceEpoch(sentTime).toString(),
                  style: Theme.of(context).textTheme.subtitle1),
              Text(msgTxt),
            ],
          )
        ],
      ),
    );
  }

  _composeMessage() {
    return TextField(
      controller: _textController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            _onTextSubmitted(_textController.text);
          },
        ),
      ),
    );
  }

  Future<void> _onTextSubmitted(String text) async {
    _textController.clear();
    setState(() {});
    _firebaseDatabase.push().set({
      "senderName": _user.displayName,
      "senderId": _user.uid,
      "text": text,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "senderPhotoUrl": _user.photoURL,
    });
  }
}
