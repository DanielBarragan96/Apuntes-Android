import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Graficas extends StatefulWidget {
  final List<Map<String, dynamic>> listaDatos;
  final bool showBarChart;

  Graficas({
    Key key,
    @required this.listaDatos,
    @required this.showBarChart,
  }) : super(key: key);

  @override
  _GraficasState createState() => _GraficasState();
}

class _GraficasState extends State<Graficas> {
  @override
  Widget build(BuildContext context) {
    var _colors =
        charts.MaterialPalette.getOrderedPalettes(widget.listaDatos.length);
    return Container(child: _simpleChart(_colors));
  }

  Widget _simpleChart(dynamic colors) {
    var _charElements = List<charts.Series<_ChartObject, String>>();

    var _chartData = widget.listaDatos
        .map(
          (e) => _ChartObject(
            xAxis: e["producto"],
            yAxis: e["cantidad"],
          ),
        )
        .toList();

    _charElements.add(
      charts.Series<_ChartObject, String>(
        id: "Grafica132456",
        data: _chartData,
        measureFn: (object, _) => object.yAxis,
        domainFn: (object, _) => object.xAxis,
        colorFn: (object, index) => colors[index].shadeDefault,
        labelAccessorFn: (object, _) => "${object.xAxis} : ${object.yAxis}",
      ),
    );

    if (widget.showBarChart) {
      return charts.BarChart(
        _charElements,
        animate: true,
        behaviors: [
          charts.ChartTitle("Producto"),
          charts.DatumLegend(
            desiredMaxRows: 2,
          ),
        ],
      );
    } else {
      return charts.PieChart(
        _charElements,
        animate: true,
        behaviors: [
          charts.ChartTitle("Producto"),
          charts.DatumLegend(
            desiredMaxRows: 2,
            position: charts.BehaviorPosition.bottom,
          ),
        ],
        defaultRenderer: charts.ArcRendererConfig(
          arcRatio: 0.6,
          arcRendererDecorators: [
            charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.auto,
            )
          ],
        ),
      );
    }
  }
}

class _ChartObject {
  final String xAxis;
  final int yAxis;

  _ChartObject({
    @required this.xAxis,
    @required this.yAxis,
  });
}
