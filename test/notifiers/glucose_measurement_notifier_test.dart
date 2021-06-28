import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/models/glucose_measurment.dart';
import 'package:glucose_levels_tracker/notifiers/glucose_measurement_notifier.dart';
import 'package:mockito/mockito.dart';

class MockCallbackFn extends Mock {
  call();
}

main() {
  group('GlucoseMeasurementNotifier', () {
    List<GlucoseMeasurement> measurements = [];
    DateTime firstDateTime = DateTime(2021, 06, 27, 10, 55);
    DateTime midDateTime = DateTime(2021, 06, 28, 09, 30);
    DateTime lastDateTime = DateTime(2021, 06, 30, 13, 25);

    setUp(() {
      measurements = [
        GlucoseMeasurement(6.3, firstDateTime, 'mmol/L'),
        GlucoseMeasurement(6.7, midDateTime, 'mmol/L'),
        GlucoseMeasurement(7.8, lastDateTime, 'mmol/L'),
      ];
    });
    test('should correctly initialise fields', () {
      final notifier = GlucoseMeasurementNotifier(measurements);

      expect(notifier.measurements, measurements);
      expect(notifier.minGlucoseLevel, 6.3);
      expect(notifier.maxGlucoseLevel, 7.8);
      expect(notifier.avgGlucoseLevel, 6.93);
      expect(notifier.medianGlucoseLevel, 6.7);
      expect(notifier.startDate, firstDateTime);
      expect(notifier.endDate, lastDateTime);
      expect(notifier.selectedDateRange,
          DateTimeRange(start: firstDateTime, end: lastDateTime));
    });

    test('setSelectedDateRange should update date range', () {
      final notifier = GlucoseMeasurementNotifier(measurements);

      notifier.setSelectedDateRange(
        DateTimeRange(start: firstDateTime, end: midDateTime),
      );

      final filteredMeasurements = measurements;
      filteredMeasurements.remove(measurements.last);

      expect(notifier.measurements, filteredMeasurements);
      expect(notifier.minGlucoseLevel, 6.3);
      expect(notifier.maxGlucoseLevel, 6.7);
      expect(notifier.avgGlucoseLevel, 6.5);
      expect(notifier.medianGlucoseLevel, 6.5);
      expect(notifier.startDate, firstDateTime);
      expect(notifier.endDate, lastDateTime);
      expect(notifier.selectedDateRange,
          DateTimeRange(start: firstDateTime, end: midDateTime));
    });

    test('setSelectedDateRange should notify listeners', () {
      final notifyListenerCallback = MockCallbackFn();
      final notifier = GlucoseMeasurementNotifier(measurements);
      notifier.addListener(notifyListenerCallback);

      notifier.setSelectedDateRange(
        DateTimeRange(start: firstDateTime, end: midDateTime),
      );

      verify(notifyListenerCallback());
      reset(notifyListenerCallback);
    });
  });
}
