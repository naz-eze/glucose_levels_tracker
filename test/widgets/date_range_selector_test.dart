import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/widgets/date_range_selector.dart';

void main() {
  testWidgets('Date Range Selector test', (WidgetTester tester) async {
    await tester.pumpWidget(DateRangeSelector());

    final container =
        find.byType(Container).evaluate().single.widget as Container;
    expect(container.child, null);
  });
}
