import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../core/storage/storage_service.dart';

class CalendarController extends GetxController {
  Rx<DateTime> currentMonthStart = DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  final StorageService storage = Get.find<StorageService>();

  String getDayShortName(DateTime date) {
    if (storage.getLanguage() == 'en') {
      switch (date.weekday) {
        case DateTime.saturday: return 'Sat';
        case DateTime.sunday: return 'Sun';
        case DateTime.monday: return 'Mon';
        case DateTime.tuesday: return 'Tue';
        case DateTime.wednesday: return 'Wed';
        case DateTime.thursday: return 'Thu';
        case DateTime.friday: return 'Fri';
        default: return '';
      }
    } else { // العربية
      switch (date.weekday) {
        case DateTime.saturday: return 'س';
        case DateTime.sunday: return 'ح';
        case DateTime.monday: return 'ن';
        case DateTime.tuesday: return 'ث';
        case DateTime.wednesday: return 'ر';
        case DateTime.thursday: return 'خ';
        case DateTime.friday: return 'ج';
        default: return '';
      }
    }
  }

  // توليد قائمة بكل أيام الشهر فقط
  List<DateTime> get monthDays {
    final year = currentMonthStart.value.year;
    final month = currentMonthStart.value.month;
    final daysInMonth = DateTime(year, month + 1, 0).day; // عدد أيام الشهر

    return List.generate(daysInMonth, (index) => DateTime(year, month, index + 1));
  }

  void goToPreviousMonth() {
    currentMonthStart.value = DateTime(currentMonthStart.value.year, currentMonthStart.value.month - 1, 1);
  }

  void goToNextMonth() {
    currentMonthStart.value = DateTime(currentMonthStart.value.year, currentMonthStart.value.month + 1, 1);
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    print(selectedDate.value);
  }

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }


}
