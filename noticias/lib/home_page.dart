import 'package:flutter/material.dart';
import 'created/create.dart';
import 'new/my_news.dart';
import 'noticias/noticias.dart';
import 'search/search.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  final _pagesList = [
    Noticias(),
    Search(),
    MyNews(),
    CreateNew(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pagesList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.indigo,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            label: "Noticias",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Buscar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks),
            label: "MisNoticias",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subject),
            label: "Crear",
          ),
        ],
      ),
    );
  }
}
