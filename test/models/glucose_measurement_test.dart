import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/models/glucose_measurment.dart';

main() {
  group('GlucoseMeasurement', () {
    test('should parse json', () async {
      final jsonString = {
        "value": "8.9",
        "timestamp": "2021-02-10T09:25:00",
        "unit": "mmol/L"
      };

      final actual = GlucoseMeasurement.fromJson(jsonString);

      expect(actual.value, 8.9);
      expect(actual.timestamp, DateTime(2021, 02, 10, 09, 25, 00));
      expect(actual.unit, 'mmol/L');
    });

    test('should create object string representation', () async {
      final measurement =
          GlucoseMeasurement(7.2, DateTime(2021, 06, 28, 09, 00), 'mmol/L');

      expect(measurement.toString(),
          'GlucoseMeasurement [value: 7.2, timestamp: 2021-06-28 09:00:00.000, unit: mmol/L]');
    });
  });
}
