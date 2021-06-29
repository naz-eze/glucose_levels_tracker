extension NumberOperations on double {
  double roundUp(decimalPlaces) =>
      double.parse(this.toStringAsFixed(decimalPlaces));
}
