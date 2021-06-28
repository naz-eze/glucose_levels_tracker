import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/main.dart';

void main() {
  testWidgets('Main test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Main());
    var title = 'Glucose Levels Tracker';

    // Verify MaterialApp properties
    final app =
        find.byType(MaterialApp).evaluate().single.widget as MaterialApp;
    expect(app.title, title);
    expect(ThemeData(primarySwatch: Colors.blue), app.theme);

    // Verify AppBar widget title
    expect(find.text(title), findsOneWidget);
  });
}
