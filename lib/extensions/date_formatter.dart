extension DateFormatter on DateTime {
  String dmy() {
    return "${this.day.toString().padLeft(2, '0')}/${this.month.toString().padLeft(2, '0')}/${this.year.toString()}";
  }
}
