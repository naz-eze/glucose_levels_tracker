class GlucoseMeasurement {
  final double value;
  final DateTime timestamp;
  final String unit;

  GlucoseMeasurement(this.value, this.timestamp, this.unit);

  factory GlucoseMeasurement.fromJson(Map<String, dynamic> json) {
    return GlucoseMeasurement(double.parse(json['value']),
        DateTime.parse(json['timestamp']), json['unit']);
  }

  @override
  String toString() {
    return "GlucoseMeasurement [value: $value, timestamp: $timestamp, unit: $unit]";
  }
}
