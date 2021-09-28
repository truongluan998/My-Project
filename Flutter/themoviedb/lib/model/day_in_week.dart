
import 'dart:core';

class DayInWeek {
  final int id;
  final String date;
  final String day;

  DayInWeek({required this.id, required this.date, required this.day,});
}

List<DayInWeek> fakeDataDayInWeek = [
  DayInWeek(id: 1, date: '1', day: 'Mo'),
  DayInWeek(id: 2, date: '2', day: 'Tu'),
  DayInWeek(id: 3, date: '3', day: 'We'),
  DayInWeek(id: 4, date: '4', day: 'Th'),
  DayInWeek(id: 5, date: '5', day: 'Fr'),
  DayInWeek(id: 6, date: '6', day: 'Sa'),
  DayInWeek(id: 7, date: '7', day: 'Su'),
];