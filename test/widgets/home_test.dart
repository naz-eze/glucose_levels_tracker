import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/models/glucose_measurment.dart';
import 'package:glucose_levels_tracker/notifiers/glucose_measurement_notifier.dart';
import 'package:glucose_levels_tracker/widgets/chart.dart';
import 'package:glucose_levels_tracker/widgets/date_range_selector.dart';
import 'package:glucose_levels_tracker/widgets/home.dart';
import 'package:glucose_levels_tracker/widgets/stats_indicator.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Home test', (WidgetTester tester) async {
    final startDate = DateTime(2021, 06, 28, 09, 00);
    final endDate = DateTime(2021, 09, 28, 11, 25);

    final List<GlucoseMeasurement> measurements = [
      GlucoseMeasurement(7.2, startDate, 'mmol/L'),
      GlucoseMeasurement(6.2, DateTime(2021, 07, 21, 09, 20), 'mmol/L'),
      GlucoseMeasurement(5.2, DateTime(2021, 08, 18, 10, 40), 'mmol/L'),
      GlucoseMeasurement(8.2, endDate, 'mmol/L'),
    ];

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: GlucoseMeasurementNotifier(measurements),
        child: MaterialApp(home: Home()),
      ),
    );

    // Verify column root widget
    final column =
        find.byKey(Key('home_column_key')).evaluate().single.widget as Column;
    expect(column.children.length, 3);

    // Verify date range selector properties
    final dateRangeSelector = column.children[0] as DateRangeSelector;
    expect(dateRangeSelector.startDate, startDate);
    expect(dateRangeSelector.endDate, endDate);
    expect(dateRangeSelector.selectedRange.start, startDate);
    expect(dateRangeSelector.selectedRange.end, endDate);
    expect(dateRangeSelector.onSelected, isNotNull);

    // Verify chart container properties
    final chartContainer = column.children[1] as Container;
    expect(chartContainer.padding, EdgeInsets.all(10.0));

    final chart = chartContainer.child as Chart;
    expect(chart.measurements, measurements);
    expect(chart.maxReading, 8.2);

    // Verify stats table properties
    final statsTable = column.children[2] as Table;
    expect(statsTable.children.length, 2);

    var mmolUnit = 'mmol/L';

    final minStatWidget = find
        .byKey(Key('min_stat_key'))
        .evaluate()
        .single
        .widget as StatsInidicator;
    expect(minStatWidget.title, 'Minimum');
    expect(minStatWidget.value, 5.2);
    expect(minStatWidget.unit, mmolUnit);

    final maxStatWidget = find
        .byKey(Key('max_stat_key'))
        .evaluate()
        .single
        .widget as StatsInidicator;
    expect(maxStatWidget.title, 'Maximum');
    expect(maxStatWidget.value, 8.2);
    expect(maxStatWidget.unit, mmolUnit);

    final avgStatWidget = find
        .byKey(Key('avg_stat_key'))
        .evaluate()
        .single
        .widget as StatsInidicator;
    expect(avgStatWidget.title, 'Average');
    expect(avgStatWidget.value, 6.7);
    expect(avgStatWidget.unit, mmolUnit);

    final medianStatWidget = find
        .byKey(Key('med_stat_key'))
        .evaluate()
        .single
        .widget as StatsInidicator;
    expect(medianStatWidget.title, 'Median');
    expect(medianStatWidget.value, 5.7);
    expect(medianStatWidget.unit, mmolUnit);
  });
}
