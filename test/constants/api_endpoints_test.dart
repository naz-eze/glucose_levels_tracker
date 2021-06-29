import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/constants/api_endpoints.dart';

main() {
  test('Should return correct glucose measurment endpoint', () {
    final glucoseEndpoint =
        'https://s3-de-central.profitbricks.com/una-health-frontend-tech-challenge/sample.json';
    expect(glucoseMeasurementApi, glucoseEndpoint);
  });
}
