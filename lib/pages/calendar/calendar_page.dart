import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/calendar/calendar_cubit.dart';
import 'package:flutter_application_1/pages/calendar/width/event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    late CalendarCubit _cubit = context.read<CalendarCubit>();
    return Scaffold(
      body: Column(
        children: [
          BlocConsumer<CalendarCubit, CalendarState>(
            listener: (context, state) {},
            builder: (context, state) {
              return TableCalendar(
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
                calendarFormat: _cubit.calendarFormat,
                onFormatChanged: (format) => _cubit.changeCalendar(format),
                onDaySelected: (selectedDay, focusedDay) {
                  print('dey selected ' + selectedDay.toIso8601String());
                },
              );
            },
          ),
          const SizedBox(height: 22),
          Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 150),
            itemCount: 5,
            separatorBuilder: (context, index) =>
                const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
            itemBuilder: (context, index) {
              return EventWidget(index: index);
            },
          ))
        ],
      ),
    );
  }
}
