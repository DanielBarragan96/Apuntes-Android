import 'package:flutter/material.dart';

class Tablas extends StatefulWidget {
  final List<Map<String, dynamic>> listaDatos;
  Tablas({Key key, @required this.listaDatos}) : super(key: key);

  @override
  _TablasState createState() => _TablasState();
}

class _TablasState extends State<Tablas> {
  var _columnas = List<DataColumn>();
  var _renglones = List<DataRow>();

  @override
  void initState() {
    _fillColumns();
    _fillRows();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: _columnas,
        rows: _renglones,
        sortColumnIndex: 0,
      ),
    );
  }

  void _fillColumns() {
    //TODO agregar on sort dentro del DataColumn
    _columnas = widget.listaDatos[0].entries
        .map((e) => DataColumn(label: Text("${e.key}")))
        .toList();
  }

  void _fillRows() {
    for (var item in widget.listaDatos) {
      List<DataCell> renglon = item.entries
          .map((e) => DataCell(e.key == "color"
              ? Container(
                  height: 8,
                  width: 8,
                  color: Color(int.parse(e.value)),
                )
              : Text("${e.value}")))
          .toList();
      _renglones.add(DataRow(cells: renglon));
    }
  }
}
