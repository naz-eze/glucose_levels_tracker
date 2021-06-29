import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/widgets/date_range_selector.dart';
import 'package:mockito/mockito.dart';

class _MockCallbackFn extends Mock {
  call(DateTimeRange dateTimeRange);
}

void main() {
  late DateTime startDate;
  late DateTime endDate;
  late DateTimeRange selectedRange;
  late _MockCallbackFn onSelectedFn;

  setUp(() {
    startDate = DateTime(2021, 06, 28);
    endDate = DateTime(2021, 07, 12);
    selectedRange = DateTimeRange(start: startDate, end: endDate);
    onSelectedFn = _MockCallbackFn();
  });

  tearDown(() {
    reset(onSelectedFn);
  });

  testWidgets('Date Range Selector test', (WidgetTester tester) async {
    // Build DateRangeSelector widget
    await tester.pumpWidget(MaterialApp(
      home: DateRangeSelector(
        startDate: startDate,
        endDate: endDate,
        selectedRange: selectedRange,
        onSelected: onSelectedFn,
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
    final startDateSelectorPadding = tableRow.children?.first as Padding;
    expect(startDateSelectorPadding.padding, EdgeInsets.all(8.0));

    final startDateSelector = startDateSelectorPadding.child as DateSelector;
    expect(startDateSelector.text, '28/06/2021');
    await verifyDatePickerDialogOpensAndSaves(
      tester,
      '28/06/2021',
      onSelectedFn,
      selectedRange,
    );
    await verifyDatePickerDialogOpensAndCloses(
      tester,
      '28/06/2021',
      onSelectedFn,
      selectedRange,
    );

    // Verify details on second table row
    final endDateSelectorPadding = tableRow.children?.last as Padding;
    expect(endDateSelectorPadding.padding, EdgeInsets.all(8.0));

    final endDateSelector = endDateSelectorPadding.child as DateSelector;
    expect(endDateSelector.text, '12/07/2021');
    await verifyDatePickerDialogOpensAndSaves(
      tester,
      '12/07/2021',
      onSelectedFn,
      selectedRange,
    );
    await verifyDatePickerDialogOpensAndCloses(
      tester,
      '12/07/2021',
      onSelectedFn,
      selectedRange,
    );
  });

  testWidgets('Date Selector test', (WidgetTester tester) async {
    VoidCallback onPressedFn = () => print('Pressed');

    // Build DateSelector widget
    await tester.pumpWidget(MaterialApp(
      home: DateSelector(text: '29/06/2021', onPressed: onPressedFn),
    ));

    final button =
        find.byType(ElevatedButton).evaluate().single.widget as ElevatedButton;
    final buttonText = button.child as Text;

    expect(buttonText.data, '29/06/2021');
    expect(buttonText.style, TextStyle(fontSize: 18));
    expect(button.onPressed, onPressedFn);
  });
}

Future<void> verifyDatePickerDialogOpensAndSaves(
  WidgetTester tester,
  String text,
  _MockCallbackFn onSelectedFn,
  DateTimeRange selectedRange,
) async {
  await openPickerDialog(tester, text);
  expect(find.byType(DateRangePickerDialog), findsOneWidget);

  expect(find.text('DONE'), findsOneWidget);
  await tester.tap(find.text('DONE'));
  await tester.pumpAndSettle();

  verify(onSelectedFn(selectedRange)).called(1);
}

Future<void> verifyDatePickerDialogOpensAndCloses(
    WidgetTester tester,
    String text,
    _MockCallbackFn onSelectedFn,
    DateTimeRange selectedRange) async {
  await openPickerDialog(tester, text);
  expect(find.byType(DateRangePickerDialog), findsOneWidget);

  await tester.tap(find.byIcon(Icons.close));
  await tester.pumpAndSettle();

  verifyNever(onSelectedFn(selectedRange));
}

Future<void> openPickerDialog(WidgetTester tester, String text) async {
  await tester.tap(find.text(text));
  await tester.pump();
}
