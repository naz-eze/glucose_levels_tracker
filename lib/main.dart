import 'package:flutter/material.dart';
import 'package:glucose_levels_tracker/models/glucose_measurment.dart';
import 'package:glucose_levels_tracker/notifiers/glucose_measurement_notifier.dart';
import 'package:glucose_levels_tracker/services/glucose_service.dart';
import 'package:glucose_levels_tracker/widgets/home.dart';
import 'package:http/http.dart' show Client;
import 'package:provider/provider.dart';

void main() {
  final glucoseService = GlucoseService(
      'https://s3-de-central.profitbricks.com/una-health-frontend-tech-challenge/sample.json',
      Client());
  runApp(Main(glucoseService));
}

class Main extends StatelessWidget {
  // This widget is the root of your application.
  final appTitle = 'Glucose Levels Tracker';
  final GlucoseService glucoseService;
  const Main(this.glucoseService);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: FutureBuilder(
          future: glucoseService.fetchMeasurements(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final measurements = snapshot.data as List<GlucoseMeasurement>;
              return SingleChildScrollView(
                key: Key('main_home_key'),
                child: ChangeNotifierProvider(
                  create: (context) => GlucoseMeasurementNotifier(measurements),
                  child: Home(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('An error occurred fetching glucose measurments');
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
