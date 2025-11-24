import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_app/app/modules/doctors/controllers/doctors_controller.dart';
import 'package:my_app/app/widgets/appbar_widget.dart';
import 'package:my_app/app/widgets/confirm_delete_dialog.dart';
import '../../../../generated/locales.g.dart';
import '../../../data/models/doctor_models/schedules_response.dart' as schedules;

import '../../../data/providers/doctors_provider.dart';
import '../../../utils/functions.dart';
import '../controllers/doctor_profile_controller.dart';

class DoctorShiftsPage extends StatelessWidget {
  final DoctorProfileController controller = Get.put(DoctorProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "نوبات الطبيب"),
      body: Obx(() {
        if (controller.getScheduleIsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.groupedShifts.isEmpty) {
          return const Center(child: Text("لا توجد نوبات حالياً."));
        }

        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchShifts(); // إعادة تحميل النوبات
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: _getOrderedShiftWidgets(controller.groupedShifts),


          ),
        );

      }),
    );
  }
  final List<String> _weekDaysOrder = [
    'saturday',
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
  ];

  List<Widget> _getOrderedShiftWidgets(Map<String, List<schedules.Data>> shiftsMap) {
    final entries = shiftsMap.entries.toList();

    entries.sort((a, b) =>
        _weekDaysOrder.indexOf(a.key.toLowerCase())
            .compareTo(_weekDaysOrder.indexOf(b.key.toLowerCase()))
    );

    return entries.map((entry) {
      final day = entry.key;
      final shifts = entry.value;

      return Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formatDay(day),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ...shifts.map((shift) => ListTile(
                title: Text("${shift.startTime} - ${shift.endTime}"),
                trailing: IconButton(
                  tooltip: LocaleKeys.delete_shift.tr,
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showConfirmDeleteDialog(
                      title: LocaleKeys.warning.tr,
                      message: LocaleKeys.do_you_sure_for_this_action.tr,
                      onConfirm: () => controller.deleteShift(shift.id!),
                    );
                  },
                ),
              )),
            ],
          ),
        ),
      );
    }).toList();
  }

  String _formatDay(String day) {
    final daysAr = {
      'saturday': LocaleKeys.saturday.tr,
      'sunday': LocaleKeys.sunday.tr,
      'monday': LocaleKeys.monday.tr,
      'tuesday': LocaleKeys.tuesday.tr,
      'wednesday': LocaleKeys.wednesday.tr,
      'thursday': LocaleKeys.thursday.tr,
      'friday': LocaleKeys.friday.tr,
    };
    return daysAr[day.toLowerCase()] ?? day;
  }

  // void _editShift(BuildContext context, schedules.Data shift) async {
  //   final newStart = await showTimePicker(
  //     context: context,
  //     initialTime: _parseTime(shift.startTime!),
  //   );
  //   if (newStart == null) return;
  //
  //   final newEnd = await showTimePicker(
  //     context: context,
  //     initialTime: _parseTime(shift.endTime!),
  //   );
  //   if (newEnd == null) return;
  //
  //   final success = await DoctorsProvider().updateDoctorShift(
  //     shiftId: shift.id,
  //     newStart: formatTimeOfDay(newStart),
  //     newEnd: formatTimeOfDay(newEnd),
  //   );
  //
  //   if (success) {
  //     Get.snackbar("تم التعديل", "تم تعديل النوبة بنجاح");
  //     controller.fetchShifts();
  //   }
  // }

  TimeOfDay _parseTime(String timeStr) {
    final parts = timeStr.split(":");
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
