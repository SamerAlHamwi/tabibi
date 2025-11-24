import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/calendar_controller.dart';
import '../controllers/doctor_detail_controller.dart';

class CalendarMonthWidget extends StatelessWidget {
  final CalendarController controller = Get.put(CalendarController());
  final DoctorsDoctorDetailController doctorDetailController = Get.put(DoctorsDoctorDetailController());

  CalendarMonthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final days = controller.monthDays;
      // تقسيم الأيام إلى أسابيع (كل أسبوع = 7 أيام)
      List<List<DateTime>> weeks = [];
      for (int i = 0; i < days.length; i += 7) {
        weeks.add(days.sublist(i, (i + 7) > days.length ? days.length : (i + 7)));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان وشهر السنة
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Obx(() {
                  final lang = doctorDetailController.storage.getLanguage() ?? 'ar';
                  return Text(
                    DateFormat.yMMMM(lang).format(controller.currentMonthStart.value),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  );
                }),


                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: controller.goToPreviousMonth,
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: controller.goToNextMonth,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // عرض الأسابيع (صفوف)
          ...weeks.map((week) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: week.map((date) {
                final isSelected = controller.isSameDate(date, controller.selectedDate.value);

                // تحقق من وجود مواعيد في هذا اليوم
                final hasAppointments = doctorDetailController.availableReservationsDoctor.value.data
                    ?.any((slot) {
                  if (slot.slot == null) return false;
                  final slotDate = DateTime.tryParse(slot.slot!);
                  return slotDate != null &&
                      slotDate.year == date.year &&
                      slotDate.month == date.month &&
                      slotDate.day == date.day &&
                      slot.locationAr == doctorDetailController.selectedClinic.value;
                }) ?? false;


                // تحديد ألوان الخلفية والنص
                Color backgroundColor;
                if (isSelected) {
                  backgroundColor = Colors.teal;
                } else if (hasAppointments) {
                  backgroundColor = Colors.grey.shade50;
                } else {
                  backgroundColor = Colors.grey.shade300;
                }
                Color textColor = (isSelected || hasAppointments) ? Colors.black : Colors.grey;
                return GestureDetector(
                  onTap: () => controller.selectDate(date),
                  child: Container(
                    width: 44,
                    height: 64,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(32),
                      border: isSelected ? Border.all(color: Colors.teal, width: 2) : null,
                    ),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // عند عرض أيام الأسبوع
                      Text(
                        controller.getDayShortName(date),
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor,
                        ),
                      ),


                      const SizedBox(height: 4),
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // النقطة الخضراء
                      if (hasAppointments)
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),

                ),
                );
              }).toList(),
            );
          }).toList(),
        ],
      );
    });
  }
}
