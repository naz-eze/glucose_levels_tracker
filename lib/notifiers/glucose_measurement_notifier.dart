import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glucose_levels_tracker/extensions/math_operations.dart';
import 'package:glucose_levels_tracker/models/glucose_measurment.dart';

class GlucoseMeasurementNotifier extends ChangeNotifier {
  late List<GlucoseMeasurement> _measurements;
  late List<GlucoseMeasurement> _filteredMeasurements;
  late DateTime _startDate;
  late DateTime _endDate;
  late DateTimeRange _selectedDateRange;
  late double _minGlucoseLevel;
  late double _maxGlucoseLevel;
  late double _avgGlucoseLevel;
  late double _medianGlucoseLevel;

  GlucoseMeasurementNotifier(List<GlucoseMeasurement> measurements) {
    _measurements = measurements;
    _filteredMeasurements = measurements;
    _startDate = _filteredMeasurements.first.timestamp;
    _endDate = _filteredMeasurements.last.timestamp;
    _selectedDateRange = DateTimeRange(start: _startDate, end: _endDate);

    _calculateStats();
  }

  UnmodifiableListView<GlucoseMeasurement> get measurements =>
      UnmodifiableListView(_filteredMeasurements);
  double get minGlucoseLevel => _minGlucoseLevel;
  double get maxGlucoseLevel => _maxGlucoseLevel;
  double get avgGlucoseLevel => _avgGlucoseLevel;
  double get medianGlucoseLevel => _medianGlucoseLevel;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  DateTimeRange get selectedDateRange => _selectedDateRange;

  setSelectedDateRange(DateTimeRange value) {
    _selectedDateRange = value;
    _filteredMeasurements = _measurements
        .where((element) =>
            element.timestamp
                .isAfter(value.start.subtract(Duration(days: 1))) &&
            element.timestamp.isBefore(value.end.add(Duration(days: 1))))
        .toList();
    _calculateStats();
    notifyListeners();
  }

  _calculateStats() {
    final glucoseValues = _filteredMeasurements.map((e) => e.value).toList();

    _minGlucoseLevel = glucoseValues.reduce(min);
    _maxGlucoseLevel = glucoseValues.reduce(max);
    _avgGlucoseLevel = double.parse(glucoseValues.average().toStringAsFixed(2));
    _medianGlucoseLevel = glucoseValues.median();
  }
}
