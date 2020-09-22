import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_bloc/bloc/home_bloc.dart';

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
  HomeBloc _homeBloc;

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador'),
      ),
      body: BlocProvider(
        create: (context) {
          _homeBloc = HomeBloc();
          return _homeBloc;
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is CounterModifyState) {
              return homeBody(state.counter);
            }
            return homeBody(0);
          },
        ),
      ),
    );
  }

  Widget homeBody(int counter) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 24),
          Text(
            "Contador: $counter",
            style: TextStyle(fontSize: 28),
          ),
          SizedBox(height: 16),
          MaterialButton(
            onPressed: () {
              setState(() {
                _homeBloc.add(AddEvent(addElement: true));
              });
            },
            child: Text("Sumar uno"),
            color: Colors.blue[100],
          ),
          SizedBox(height: 16),
          MaterialButton(
            onPressed: () {
              setState(() {
                _homeBloc.add(AddEvent(addElement: false));
              });
            },
            child: Text("Restar uno"),
            color: Colors.blue[100],
          ),
        ],
      ),
    );
  }
}
