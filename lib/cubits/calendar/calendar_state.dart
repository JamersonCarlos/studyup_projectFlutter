part of 'calendar_cubit.dart';

@immutable
abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarChange extends CalendarState {
  final CalendarFormat change;

  CalendarChange({required this.change});

}
class CalendarListEvents extends CalendarState {
  final List<EventWidget> events;

  CalendarListEvents({required this.events});

}
