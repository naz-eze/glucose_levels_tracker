import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glucose_levels_tracker/main.dart';
import 'package:glucose_levels_tracker/models/glucose_measurment.dart';
import 'package:glucose_levels_tracker/services/glucose_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'main_test.mocks.dart';

@GenerateMocks([GlucoseService])
void main() {
  late GlucoseService glucoseService;

  setUp(() {
    glucoseService = MockGlucoseService();
  });
  group('Main Test', () {
    List<GlucoseMeasurement> measurements = [
      GlucoseMeasurement(6.7, DateTime(2021, 04, 27), 'mmol/L')
    ];

    testWidgets('should app title', (WidgetTester tester) async {
      when(glucoseService.fetchMeasurements())
          .thenAnswer((_) => Future.value(measurements));

      await tester.pumpWidget(Main(glucoseService));
      var title = 'Glucose Levels Tracker';

      final app =
          find.byType(MaterialApp).evaluate().single.widget as MaterialApp;
      expect(app.title, title);
      expect(ThemeData(primarySwatch: Colors.blue), app.theme);

      // Verify AppBar widget title
      expect(find.text(title), findsOneWidget);
    });

    testWidgets('should show a progress indicator when loading',
        (WidgetTester tester) async {
      when(glucoseService.fetchMeasurements()).thenAnswer(
          (_) => Future.delayed(Duration(seconds: 1), () => measurements));

      await tester.pumpWidget(Main(glucoseService));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should show error message when error occurs',
        (WidgetTester tester) async {
      when(glucoseService.fetchMeasurements())
          .thenAnswer((_) => Future.error('An error occurred'));

      await tester.pumpWidget(Main(glucoseService));
      await tester.pumpAndSettle();
      expect(find.text('An error occurred fetching glucose measurments'),
          findsOneWidget);
    });

    testWidgets('should build home widget', (WidgetTester tester) async {
      when(glucoseService.fetchMeasurements())
          .thenAnswer((_) => Future.value(measurements));

      await tester.pumpWidget(Main(glucoseService));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('main_home_key')), findsOneWidget);

      final homeView = find.byKey(Key('main_home_key')).evaluate().single.widget
          as SingleChildScrollView;

      expect(homeView.child, isInstanceOf<ChangeNotifierProvider>());
      expect(find.byKey(Key('home_column_key')), findsOneWidget);
    });
  });
}
