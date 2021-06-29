import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/extensions/number_operations.dart';

main() {
  group('Number Operations', () {
    test('should round up', () {
      expect(2.656.roundUp(2), 2.66);
      expect(2.6.roundUp(2), 2.60);
      expect(2.64.roundUp(2), 2.64);
    });
  });
}
