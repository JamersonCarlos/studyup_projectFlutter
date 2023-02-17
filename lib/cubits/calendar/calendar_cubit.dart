import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  late CalendarFormat _calendarFormat = CalendarFormat.month;

  CalendarCubit() : super(CalendarInitial());

  get calendarFormat => _calendarFormat;

  changeCalendar(CalendarFormat change) {
    _calendarFormat = change;
    emit(CalendarChange(change: _calendarFormat));
  }
}
