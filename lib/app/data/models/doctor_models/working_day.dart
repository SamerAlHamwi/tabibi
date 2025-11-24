import 'package:flutter/material.dart';

class Schedule {
  TimeOfDay? from;
  TimeOfDay? to;

  Schedule({this.from, this.to});
}

class WorkingDay {
  String day;
  List<Schedule> shifts;

  WorkingDay({required this.day, required this.shifts});
}

