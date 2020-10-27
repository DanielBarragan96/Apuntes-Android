import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> _listOfWords;
  List<String> _filteredListOfWords;
  var _searchTextController = TextEditingController();

  @override
  void initState() {
    _filteredListOfWords = List();
    _listOfWords = [
      "Hola",
      "Mundo",
      "Mexico",
      "Murcielago",
      "Honduras",
      "Anita",
      "Lava",
      "La",
      "Tina",
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Buscar"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                controller: _searchTextController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: "Buscar palabra ...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                onChanged: (value) {
                  _filterText();
                },
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: _filteredListOfWords.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return Text("${_filteredListOfWords[index]}");
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _filterText() {
    setState(() {
      if (_searchTextController.text == "") {
        _filteredListOfWords = List();
        return;
      }
      _filteredListOfWords = _listOfWords
          .where((palabra) => palabra
              .toLowerCase()
              .contains(_searchTextController.text.toLowerCase()))
          .toList();
    });
  }
}
