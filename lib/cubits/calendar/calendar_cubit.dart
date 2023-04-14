import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../pages/calendar/widget/event.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  late CalendarFormat _calendarFormat = CalendarFormat.week;
  late DateTime _focusedDay = DateTime.now();

  CalendarCubit() : super(CalendarInitial());

  get calendarFormat => _calendarFormat;

  get focusedDay => _focusedDay;

  changeCalendar(CalendarFormat change) {
    _calendarFormat = change;
    emit(CalendarChange(change: _calendarFormat));
  }

  Future<void> emitFocusedDay(DateTime focusedDay) async {
    _focusedDay = focusedDay;
    await Future.delayed(const Duration(milliseconds: 20));
    emit(CalendarFocusedDay(focusedDay: focusedDay));
  }
}
