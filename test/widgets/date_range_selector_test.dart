import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/widgets/date_range_selector.dart';

void main() {
  testWidgets('Date Range Selector test', (WidgetTester tester) async {
    final DateTime startDate = DateTime(2021, 06, 28);
    final DateTime endDate = DateTime(2021, 07, 12);
    final DateTimeRange selectedRange =
        DateTimeRange(start: startDate, end: endDate);

    // Build DateRangeSelector widget

    await tester.pumpWidget(MaterialApp(
      home: DateRangeSelector(
        startDate: startDate,
        endDate: endDate,
        selectedRange: selectedRange,
      ),
    ));

    // Verify Table widget exist and contains one child
    final table = find.byType(Table).evaluate().single.widget as Table;
    expect(table.children.length, 1);

    // Verify TableRow contains two children
    final tableRow = table.children[0];
    expect(tableRow.children, isNot(null));
    expect(tableRow.children?.length, 2);

    // Verify details on first table row
    final startDateButton = tableRow.children?.first as ElevatedButton;
    final startDateButtonText = startDateButton.child as Text;
    expect(startDateButtonText.data, '28/06/2021');
    expect(
      startDateButtonText.style,
      TextStyle(fontSize: 18, color: Colors.black),
    );
    await verifyDatePickerDialogOpens(tester, '28/06/2021');

    // Verify details on second table row
    final endDateButton = tableRow.children?.last as ElevatedButton;
    final endDateButtonText = endDateButton.child as Text;
    expect(endDateButtonText.data, '12/07/2021');
    expect(
      endDateButtonText.style,
      TextStyle(fontSize: 18, color: Colors.black),
    );
    await verifyDatePickerDialogOpens(tester, '12/07/2021');
  });
}

Future<void> verifyDatePickerDialogOpens(
    WidgetTester tester, String text) async {
  await tester.tap(find.text(text));
  await tester.pump();
  expect(find.byType(DateRangePickerDialog), findsOneWidget);
  await tester.tap(find.byIcon(Icons.close));
  await tester.pumpAndSettle();
}
