import 'package:flutter/material.dart';
import 'package:glucose_levels_tracker/notifiers/glucose_measurement_notifier.dart';
import 'package:glucose_levels_tracker/widgets/chart.dart';
import 'package:glucose_levels_tracker/widgets/date_range_selector.dart';
import 'package:glucose_levels_tracker/widgets/stats_indicator.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screnHeight = screenSize.height;
    final defaultPadding = const EdgeInsets.all(8.0);

    return Consumer<GlucoseMeasurementNotifier>(
      builder: (_, notifier, __) {
        final measurementUnit = 'mmol/L';
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          child: Column(
            key: Key('home_column_key'),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateRangeSelector(
                startDate: notifier.startDate,
                endDate: notifier.endDate,
                selectedRange: notifier.selectedDateRange,
                onSelected: (newDateRange) =>
                    notifier.setSelectedDateRange(newDateRange),
              ),
              Container(
                height: screnHeight * 0.45, //verify in Integration Tests
                width: screenWidth,
                padding: const EdgeInsets.all(10),
                child: Chart(
                  measurements: notifier.measurements,
                  maxReading: notifier.maxGlucoseLevel,
                ),
              ),
              Table(
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: defaultPadding,
                        child: StatsInidicator(
                          key: Key('min_stat_key'),
                          title: 'Minimum',
                          value: notifier.minGlucoseLevel,
                          unit: measurementUnit,
                          // onPressed: notifier.displayMinValue,
                        ),
                      ),
                      Padding(
                        padding: defaultPadding,
                        child: StatsInidicator(
                          key: Key('max_stat_key'),
                          title: 'Maximum',
                          value: notifier.maxGlucoseLevel,
                          unit: measurementUnit,
                          // onPressed: notifier.displayMaxValue,
                        ),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: defaultPadding,
                        child: StatsInidicator(
                          key: Key('avg_stat_key'),
                          title: 'Average',
                          value: notifier.avgGlucoseLevel,
                          unit: measurementUnit,
                        ),
                      ),
                      Padding(
                        padding: defaultPadding,
                        child: StatsInidicator(
                          key: Key('med_stat_key'),
                          title: 'Median',
                          value: notifier.medianGlucoseLevel,
                          unit: measurementUnit,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
