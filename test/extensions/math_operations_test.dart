import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/extensions/math_operations.dart';

void main() {
  group('Math Operations', () {
    final List<double> list = [2.4, 3.5, 2.6, 2.5, 7.5];

    test('should calculate median', () {
      expect(list.median(), 2.6);
    });

    test('should calculate average', () {
      expect(list.average(), 3.7);
    });
  });
}
