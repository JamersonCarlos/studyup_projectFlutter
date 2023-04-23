import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/calendar/calendar_cubit.dart';
import 'package:flutter_application_1/pages/calendar/widget/event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../cubits/metas/metas_cubit.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({super.key, required this.uid});

  String uid;
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    late CalendarCubit _cubit = context.read<CalendarCubit>();
    late MetasCubit _cubitMetas = context.read<MetasCubit>();
    _cubitMetas.getMetasByUidUser(widget.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calendário",
          style: GoogleFonts.balooPaaji2(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          BlocConsumer<CalendarCubit, CalendarState>(
            listener: (context, state) {},
            builder: (context, state) {
              return TableCalendar(
                locale: 'pt-br',
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _cubit.focusedDay,
                currentDay: _cubit.focusedDay,
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.indigo,
                    // borderRadius:  BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                eventLoader: (day) {
                  if (day.weekday == DateTime.monday) {
                    return ['Cyclic event'];
                  }

                  return [];
                },
                calendarFormat: _cubit.calendarFormat,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                ),
                onFormatChanged: (format) => _cubit.changeCalendar(format),
                onDaySelected: (selectedDay, focusedDay) {
                  _cubit.emitFocusedDay(focusedDay);
                  _cubitMetas.filterMetasByDay(selectedDay);
                },
              );
            },
          ),
          const SizedBox(height: 22),
          BlocConsumer<MetasCubit, MetasState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is MetasLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is MetasLoaded) {
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 150),
                    itemCount: state.metas.length,
                    separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6)),
                    itemBuilder: (context, index) {
                      return EventWidget(
                          index: index, meta: state.metas[index]);
                    },
                  ),
                );
              } else {
                return const Center(child: Text('Erro ao carregar as metas'));
              }
            },
          )
        ],
      ),
    );
  }
}
