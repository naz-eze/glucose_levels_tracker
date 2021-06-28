import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/exceptions/rest_exception.dart';

main() {
  test('RestException test', () async {
    final message = 'An exception occurred';
    final excepetion = RestException(message);

    expect(excepetion.message, message);
    expect(excepetion.toString(), 'RestException: An exception occurred');
  });
}
