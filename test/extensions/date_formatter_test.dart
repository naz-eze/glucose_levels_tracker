import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/extensions/date_formatter.dart';

void main() {
  group('Date Formatter', () {
    test('dmy function should format date in DD/MM/YYY format', () {
      final DateTime dateTime = DateTime(2021, 06, 28);
      expect(dateTime.dmy(), '28/06/2021');
    });

    test('dm function should format date in DD/MM format', () {
      final DateTime dateTime = DateTime(2021, 11, 30);
      expect(dateTime.dm(), '30/11');
    });
  });
}
