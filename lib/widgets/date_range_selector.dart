import 'package:flutter/material.dart';
import 'package:glucose_levels_tracker/extensions/date_formatter.dart';

class DateRangeSelector extends StatelessWidget {
  final DateTime startDate, endDate;
  final DateTimeRange selectedRange;

  const DateRangeSelector(
      {Key? key,
      required this.startDate,
      required this.endDate,
      required this.selectedRange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future _selectDateRange(BuildContext context) async {
      final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: startDate,
        lastDate: endDate,
        initialDateRange: selectedRange,
      );
      if (newDateRange == null) return;
    }

    return Table(
      children: [
        TableRow(
          children: [
            DateSelector(
              text: startDate.dmy(),
              onPressed: () => _selectDateRange(context),
            ),
            DateSelector(
              text: endDate.dmy(),
              onPressed: () => _selectDateRange(context),
            ),
          ],
        ),
      ],
    );
  }
}

class DateSelector extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DateSelector({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        onPressed: onPressed,
      );
}
