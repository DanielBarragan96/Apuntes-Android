import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _switchValue = false;
  bool _checkboxValue = false;
  double _sliderValue = 2.0;
  String _dropSelectedValue = "tres";
  static const List<String> _options = ["uno", "dos", "tres", "cuatro"];
  final List<DropdownMenuItem<String>> _itemOptionList = _options
      .map(
        (element) => DropdownMenuItem<String>(
          value: element,
          child: Text(element),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc()..add(LoadConfigsEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is ErrorState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("${state.errorMessage}"),
                  ),
                );
            } else if (state is LoadedDataState) {
              _dropSelectedValue = state.configs["drops"];
              _switchValue = state.configs["switch"];
              _checkboxValue = state.configs["checkbox"];
              _sliderValue = state.configs["slider"];
            }
          },
          builder: (context, state) {
            return _buildListView(context);
          },
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView(
      children: [
        // dropdown
        ListTile(
          title: Text("Dropdown"),
          trailing: DropdownButton(
              value: _dropSelectedValue,
              items: _itemOptionList,
              onChanged: (newValue) {
                _dropSelectedValue = newValue;
                setState(() {});
              }),
        ),
        Divider(),
        // switch
        ListTile(
          title: Text("Switch"),
          trailing: Switch(
              value: _switchValue,
              onChanged: (newValue) {
                _switchValue = newValue;
                setState(() {});
              }),
        ),
        Divider(),
        // checkbox
        ListTile(
          title: Text("Checkbox"),
          trailing: Checkbox(
              tristate: false,
              value: _checkboxValue,
              onChanged: (newValue) {
                _checkboxValue = newValue;
                setState(() {});
              }),
        ),
        Divider(),
        Text("Slider"),
        Slider(
          value: _sliderValue,
          min: 0,
          max: 10,
          divisions: 5,
          label: "${_sliderValue.round()}",
          onChanged: (newValue) {
            _sliderValue = newValue;
            setState(() {});
          },
        ),
        Divider(),
        MaterialButton(
          onPressed: () {
            BlocProvider.of<HomeBloc>(context).add(
              SaveConfigsEvent(
                {
                  "drop": _dropSelectedValue,
                  "switch": _switchValue,
                  "checkbox": _checkboxValue,
                  "slider": _sliderValue,
                },
              ),
            );
          },
          child: Text("Guardar"),
          color: Colors.blue[100],
        )
      ],
    );
  }
}
