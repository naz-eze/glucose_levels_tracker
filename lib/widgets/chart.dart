import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:glucose_levels_tracker/extensions/date_formatter.dart';
import 'package:glucose_levels_tracker/models/glucose_measurment.dart';

class Chart extends StatelessWidget {
  final List<GlucoseMeasurement> measurements;
  final double maxReading;

  const Chart({Key? key, required this.measurements, required this.maxReading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _gradientColors = [
      Colors.lightBlue,
      Colors.blue,
    ];

    final _titleStyles = TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontSize: 9,
    );

    final _values = measurements.map((measurement) {
      return FlSpot(
        measurement.timestamp.millisecondsSinceEpoch.toDouble(),
        measurement.value,
      );
    }).toList();

    final _intervalRatio = 4;
    final _interval = ((_values.last.x - _values.first.x) / _intervalRatio);
    final _defaultInterval = 1.0;

    return LineChart(
      LineChartData(
        minX: _values.first.x,
        maxX: _values.last.x,
        minY: 0,
        maxY: maxReading + 1.0,
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.lightBlue, width: 1),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: _values,
            isCurved: true,
            barWidth: 2,
            colors: _gradientColors,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              colors: _gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          )
        ],
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => _titleStyles,
            getTitles: (value) {
              final DateTime date =
                  DateTime.fromMillisecondsSinceEpoch(value.toInt());
              return date.dm();
            },
            margin: 8,
            interval: _interval == 0 ? _defaultInterval : _interval,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => _titleStyles,
            getTitles: (value) => value.toString(),
            margin: 8,
          ),
        ),
      ),
    );
  }
}
