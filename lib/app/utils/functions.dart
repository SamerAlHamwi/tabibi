import 'package:flutter/material.dart';
String formatTimeOfDayPmAm(BuildContext context, TimeOfDay time) {
  final int hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
  final String minute = time.minute.toString().padLeft(2, '0');
  final String period = time.period == DayPeriod.am ? "صباحاً" : "مساءً";

  return "$hour:$minute $period";
}


String formatTimeOfDay(TimeOfDay time) {
  final String hour = time.hour.toString().padLeft(2, '0');
  final String minute = time.minute.toString().padLeft(2, '0');
  const String second = '00'; // الثواني ثابتة إذا لم تُرسل

  return '$hour:$minute:$second';
}

String formatSelectedTime(TimeOfDay selectedTime) {
  final hour = selectedTime.hour.toString().padLeft(2, '0');
  final minute = selectedTime.minute.toString().padLeft(2, '0');
  return "$hour:$minute:00";
}


String formatSelectedDate(DateTime selectedDate) {
  return "${selectedDate.year.toString().padLeft(4, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
}

int calculateSessionDurationInMinutes({
  required TimeOfDay startTime,
  required TimeOfDay endTime,
  required int numberOfSessions,
}) {
  int startMinutes = startTime.hour * 60 + startTime.minute;
  int endMinutes = endTime.hour * 60 + endTime.minute;

  if (endMinutes < startMinutes) {
    endMinutes += 24 * 60;
  }

  int totalDuration = endMinutes - startMinutes;

  if (numberOfSessions <= 0) {
    throw ArgumentError('عدد الجلسات يجب أن يكون أكبر من 0');
  }

  return (totalDuration / numberOfSessions).floor();
}

