import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/exceptions/rest_exception.dart';
import 'package:glucose_levels_tracker/models/glucose_measurment.dart';
import 'package:glucose_levels_tracker/services/glucose_service.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:http/testing.dart';

main() {
  group('GlucoseService', () {
    test('should return measurements sorted by timestamp', () async {
      final url = 'https://faker.com/measurements.json';
      final client = MockClient((request) async {
        final jsonResponse = {
          "bloodGlucoseSamples": [
            {
              "value": "8.5",
              "timestamp": "2021-02-10T10:55:00",
              "unit": "mmol/L"
            },
            {
              "value": "7.7",
              "timestamp": "2021-02-10T09:08:00",
              "unit": "mmol/L"
            },
            {
              "value": "6.7",
              "timestamp": "2021-02-22T14:22:00",
              "unit": "mmol/L"
            },
          ]
        };
        return Response(json.encode(jsonResponse), 200);
      });

      final service = GlucoseService(url, client);

      final measurements = await service.fetchMeasurements();

      expect(measurements.length, 3);
      expect(measurements[0],
          GlucoseMeasurement(7.7, DateTime(2021, 02, 10, 09, 08), 'mmol/L'));
      expect(measurements[1],
          GlucoseMeasurement(8.5, DateTime(2021, 02, 10, 10, 55), 'mmol/L'));
      expect(measurements[2],
          GlucoseMeasurement(6.7, DateTime(2021, 02, 22, 14, 22), 'mmol/L'));
    });

    test('should throw exception for invalid REST response', () async {
      final url = 'https://faker.com/measurements.json';
      final client = MockClient((request) async {
        return Response('Internal Server Error', 500);
      });

      final service = GlucoseService(url, client);
      expect(() => service.fetchMeasurements(), throwsA(isA<RestException>()));
    });
  });
}
