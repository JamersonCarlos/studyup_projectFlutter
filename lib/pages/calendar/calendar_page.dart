import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TableCalendar(
            locale: 'pt-br',
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ),
            
            eventLoader: (day) {
              if (day.weekday == DateTime.monday) {
                return ['Cyclic event'];
              }

              return [];
            },
            onDaySelected: (selectedDay, focusedDay) {
              print('dey selected '+ selectedDay.toIso8601String());
            },
          ),
          const SizedBox(height: 12),
          Expanded(child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(title: Text("Event$index"),
              leading: const Icon(Icons.calendar_month),);
          },))
        ],
      ),
    );
  }
}

