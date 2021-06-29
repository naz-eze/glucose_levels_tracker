import 'package:flutter/material.dart';
import 'package:glucose_levels_tracker/extensions/date_formatter.dart';

class DateRangeSelector extends StatelessWidget {
  final DateTime startDate, endDate;
  final DateTimeRange selectedRange;
  final Function(DateTimeRange newDateRange) onSelected;
  final defaultPadding = const EdgeInsets.all(8.0);

  const DateRangeSelector({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.selectedRange,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future _selectDateRange(BuildContext context) async {
      final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: startDate,
        lastDate: endDate,
        initialDateRange: selectedRange,
        saveText: 'DONE',
      );
      if (newDateRange == null) return;
      onSelected(newDateRange);
    }

    return Table(
      children: [
        TableRow(
          children: [
            Padding(
              padding: defaultPadding,
              child: DateSelector(
                text: selectedRange.start.dmy(),
                onPressed: () => _selectDateRange(context),
              ),
            ),
            Padding(
              padding: defaultPadding,
              child: DateSelector(
                text: selectedRange.end.dmy(),
                onPressed: () => _selectDateRange(context),
              ),
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
        child: Text(text, style: TextStyle(fontSize: 18)),
        onPressed: onPressed,
      );
}
