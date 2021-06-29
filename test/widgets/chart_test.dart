import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/models/glucose_measurment.dart';
import 'package:glucose_levels_tracker/widgets/chart.dart';

void main() {
  testWidgets('Chart test should correctly build chart widget',
      (WidgetTester tester) async {
    final firstDateTime = DateTime(2021, 06, 28, 10, 55);
    final lastDateTime = DateTime(2021, 06, 30, 13, 25);

    // Build Chart widget
    final List<GlucoseMeasurement> measurements = [
      GlucoseMeasurement(6.3, firstDateTime, 'mmol/L'),
      GlucoseMeasurement(7.8, DateTime(2021, 06, 29, 09, 30), 'mmol/L'),
      GlucoseMeasurement(8.2, lastDateTime, 'mmol/L')
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: Directionality(
            textDirection: TextDirection.ltr,
            child: Chart(
              measurements: measurements,
              maxReading: 8.2,
            )),
      ),
    );

    final lineChart =
        find.byType(LineChart).evaluate().single.widget as LineChart;

    // Verify LineChartData properties
    final lineChartData = lineChart.data;
    expect(lineChartData.minX, firstDateTime.millisecondsSinceEpoch.toDouble());
    expect(lineChartData.maxX, lastDateTime.millisecondsSinceEpoch.toDouble());
    expect(lineChartData.minY, 0);
    expect(lineChartData.maxY, 9.2);
    expect(lineChartData.borderData.show, true);
    expect(lineChartData.borderData.border,
        Border.all(color: Colors.lightBlue, width: 1));

    // Verify lineBarsData properties
    final lineBarsData = lineChartData.lineBarsData;
    expect(lineBarsData.length, 1);
    expect(lineBarsData[0].spots.length, 3);
    expect(lineBarsData[0].isCurved, true);
    expect(lineBarsData[0].barWidth, 2);
    expect(lineBarsData[0].dotData, FlDotData(show: false));
    expect(lineBarsData[0].belowBarData.show, true);
    expect(lineBarsData[0].belowBarData.colors, isNotNull);

    // Verify titlesData properties
    final titlesData = lineChartData.titlesData;
    expect(titlesData.show, true);
    expect(titlesData.bottomTitles.showTitles, true);
    expect(titlesData.bottomTitles.margin, 8);
    expect(titlesData.bottomTitles.getTextStyles, isNotNull);
    expect(titlesData.bottomTitles.getTitles, isNotNull);
    expect(
        titlesData.bottomTitles.interval,
        (lastDateTime.millisecondsSinceEpoch -
                firstDateTime.millisecondsSinceEpoch) /
            4);

    // Verify leftTitles properties
    expect(titlesData.leftTitles.showTitles, true);
    expect(titlesData.leftTitles.margin, 8);
    expect(titlesData.leftTitles.getTextStyles, isNotNull);
    expect(titlesData.leftTitles.getTitles, isNotNull);
  });

  testWidgets('should use default interval', (WidgetTester tester) async {
    // Build Chart widget with one measurement
    final List<GlucoseMeasurement> measurements = [
      GlucoseMeasurement(7.8, DateTime(2021, 06, 29, 09, 30), 'mmol/L')
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: Chart(
            measurements: measurements,
            maxReading: 7.8,
          ),
        ),
      ),
    );

    final lineChart =
        find.byType(LineChart).evaluate().single.widget as LineChart;
    final titlesData = lineChart.data.titlesData;
    expect(titlesData.bottomTitles.interval, 1.0);
  });
}
