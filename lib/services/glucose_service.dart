import 'dart:convert';
import 'dart:developer' as developer;

import 'package:glucose_levels_tracker/exceptions/rest_exception.dart';
import 'package:glucose_levels_tracker/models/glucose_measurment.dart';
import 'package:http/http.dart' show Client;

class GlucoseService {
  final String _url;
  final Client _client;

  GlucoseService(this._url, this._client);

  Future<List<GlucoseMeasurement>> fetchMeasurements() async {
    final response = await _client.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final measurements =
          jsonDecode(response.body)['bloodGlucoseSamples'] as List;

      final futureMeasurements = Stream.fromIterable(measurements)
          .asyncMap((measurement) => GlucoseMeasurement.fromJson(measurement))
          .toList();

      futureMeasurements.then((measurement) =>
          measurement.sort((_, __) => _.timestamp.compareTo(__.timestamp)));

      return futureMeasurements;
    } else {
      final errorMessage =
          'An error occurred fetching glucose measurements. ResponseCode: ${response.statusCode}';
      developer.log(errorMessage, name: 'app.glucose_service', error: response);
      throw RestException(errorMessage);
    }
  }
}
