extension DateFormatter on DateTime {
  String dmy() {
    return "${dm()}/${this.year.toString()}";
  }

  String dm() {
    return "${this.day.toString().padLeft(2, '0')}/${this.month.toString().padLeft(2, '0')}";
  }
}
