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
            ElevatedButton(
              child: Text(
                startDate.dmy(),
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              onPressed: () => _selectDateRange(context),
            ),
            ElevatedButton(
              child: Text(
                endDate.dmy(),
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              onPressed: () => _selectDateRange(context),
            ),
          ],
        ),
      ],
    );
  }
}
