import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class AppDatePicker {
  static final List<DateTime?> _dialogCalendarPickerValue = <DateTime?>[
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now(),
  ];

  static TimeOfDay timeOfDay = TimeOfDay.now();

  static Future<DateTime?> showMonthYearPicker(
    BuildContext context,
  ) async {
    final DateTime? res = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
    );
    return res;
  }

  static Future<DateRangeValues> showDateRangePicker(
      BuildContext context) async {
    final List<DateTime?>? results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
      ),
      dialogSize: const Size(325, 400),
      value: _dialogCalendarPickerValue,
      borderRadius: BorderRadius.circular(15),
    );
    final DateRangeValues values = DateRangeValues(
      startDate: results?.first,
      endDate: results?.last,
    );
    return values;
  }

  static Future<DateTime?> showOnlyDatePicker(
      BuildContext context) async {
    final List<DateTime?>? value = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        selectableDayPredicate: (DateTime day) => !day
            .difference(_dialogCalendarPickerValue[0]!
                .subtract(const Duration(days: 5)))
            .isNegative,
      ),
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(15),
     // value: _dialogCalendarPickerValue,
    );

    return value?[0];
  }

  static Future<String?> displayTimePicker(
    BuildContext context,
  ) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );
    final String formattedTime = time.toString().split('(')[1].split(')')[0];
    return formattedTime;
  }
}

class DateRangeValues {
  DateRangeValues({required this.startDate, required this.endDate});

  final DateTime? startDate;
  final DateTime? endDate;
}
