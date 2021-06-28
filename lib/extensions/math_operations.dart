extension MathOperations on List<double> {
  //https://pub.dev/documentation/scidart/latest/numdart/median.html
  double median() {
    var mid = this.length ~/ 2;
    if (this.length % 2 == 1) {
      return this[mid];
    } else {
      return (this[mid - 1] + this[mid]) / 2.0;
    }
  }

  double average() => this.reduce((a, b) => a + b) / this.length;
}
