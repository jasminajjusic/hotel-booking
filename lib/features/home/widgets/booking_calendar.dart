import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingCalendar extends HookWidget {
  final ValueChanged<DateTime> onDateSelected;

  const BookingCalendar({super.key, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    final focusedDay = useState(DateTime.now());
    final selectedDay = useState<DateTime?>(null);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        focusedDay: focusedDay.value,
        selectedDayPredicate: (day) => isSameDay(selectedDay.value, day),
        calendarFormat: CalendarFormat.month,
        availableCalendarFormats: const {CalendarFormat.month: 'Month'},
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            color: Color(0xFF165244),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          leftChevronIcon: Icon(Icons.chevron_left, color: Color(0xFF165244)),
          rightChevronIcon: Icon(Icons.chevron_right, color: Color(0xFF165244)),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Colors.grey),
          weekendStyle: TextStyle(color: Colors.grey),
        ),
        calendarStyle: const CalendarStyle(
          defaultTextStyle: TextStyle(color: Colors.black),
          weekendTextStyle: TextStyle(color: Colors.black),
          outsideTextStyle: TextStyle(color: Colors.grey),
          todayDecoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(color: Color(0xFF165244), width: 2),
            ),
          ),
          todayTextStyle: TextStyle(
            color: Color(0xFF165244),
            fontWeight: FontWeight.bold,
          ),
          selectedDecoration: BoxDecoration(
            color: Color(0xFF165244),
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        onDaySelected: (day, focus) {
          selectedDay.value = day;
          focusedDay.value = focus;
          onDateSelected(day);
        },
      ),
    );
  }
}
