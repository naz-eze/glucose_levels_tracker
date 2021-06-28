import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/widgets/stats_indicator.dart';

void main() {
  testWidgets('Stats Indicator test', (WidgetTester tester) async {
    final title = 'Minimum';
    final value = 8.4;
    final unit = 'mmol/L';
    final onPressedFn = () => print('Stats');

    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: StatsInidicator(
        title: title,
        value: value,
        unit: unit,
        onPressed: onPressedFn,
      ),
    ));

    final card = find.byType(Card).evaluate().single.widget as Card;
    expect(card.color, Colors.lightBlue[100]);
    expect(
      card.shape,
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
    final inkwell = card.child as InkWell;
    expect(inkwell.splashColor, Colors.lightBlue.withAlpha(30));
    expect(inkwell.onLongPress, onPressedFn);
    expect(inkwell.onTap, onPressedFn);

    expect(find.text('Minimum'), findsOneWidget);

    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is RichText && widget.text.toPlainText() == '8.4 mmol/L'),
        findsOneWidget);
  });
}
