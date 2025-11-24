import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app/theme/app_colors.dart';
import '../../../../generated/locales.g.dart';
import '../../../data/models/doctor_models/clinc_model.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/functions.dart';
import '../../../widgets/confirm_delete_dialog.dart';
import '../controllers/doctor_profile_controller.dart';
import '../views/doctor_profile_view.dart';

class WorkingDaysWidget extends StatelessWidget {
  final DoctorProfileController controller =
      Get.find<DoctorProfileController>();

  WorkingDaysWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.working_days_and_hours.tr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(() {
              if (controller.clinics.isEmpty) {
                return  Text(LocaleKeys.no_clinics_available.tr);
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Clinic>(
                      isExpanded: true,
                      value: controller.selectedClinic.value ??
                          controller.clinics.first,
                      onChanged: (clinic) {
                        if (clinic != null) {
                          controller.selectedClinic.value = clinic;
                          print(controller.selectedClinic.value!.address);
                          print(controller.selectedClinic.value!.governorate);
                        }
                      },
                      items: controller.clinics.map((clinic) {
                        return DropdownMenuItem<Clinic>(
                          value: clinic,
                          child: Container(
                            width: 200,
                            // 👈 العرض المطلوب للقائمة المنسدلة البيضاء
                            child: Text(
                              '${clinic.governorate} - ${clinic.address}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 16),
            const SizedBox(height: 12),
            // بدّل loop الرئيسي بهذا الشكل:

            for (int i = 0; i < controller.workingDays.length; i++)
              Card(
                color: AppColors.scaffoldBackground,
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${LocaleKeys.day.tr}: ${controller.workingDays[i].day}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ...List.generate(controller.workingDays[i].shifts.length,
                          (j) {
                        final shift = controller.workingDays[i].shifts[j];
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () =>
                                    controller.pickTime(i, j, true),
                                child: Text(
                                  shift.from != null
                                      ? "${LocaleKeys.from.tr}: ${formatTimeOfDayPmAm(context, shift.from!)}"
                                      : LocaleKeys.start_time.tr,
                                ),

                              ),
                              const SizedBox(width: 2),
                              TextButton(
                                onPressed: () =>
                                    controller.pickTime(i, j, false),
                                child: Text(
                                  shift.to != null
                                      ? "${LocaleKeys.to.tr}: ${formatTimeOfDayPmAm(context, shift.to!)}"
                                      : LocaleKeys.end_time.tr,
                                ),
                              ),
                              IconButton(
                                icon: Text(
                                  LocaleKeys.confirm.tr,
                                  style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: LocaleKeys.confirm_add_shift.tr,
                                    content: PasswordConfirmationDialog(
                                      title: LocaleKeys.add_number_of_sessions_for_this_episode.tr,
                                      onConfirm: (reservationDuration) {
                                        int numMinutes =
                                            calculateSessionDurationInMinutes(
                                                startTime: shift.from!,
                                                endTime: shift.to!,
                                                numberOfSessions:
                                                    reservationDuration);
                                        controller.addSchedules(i, j,
                                            numMinutes); // أرسل كلمة المرور
                                      },
                                    ),
                                  );
                                  // أرسل النوبة الحالية
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  controller.removeShift(i, j);
                                },
                              )
                            ],
                          ),
                        );
                      }),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () => controller.addShiftToDay(i),
                          icon: const Icon(Icons.add),
                          label: Text(LocaleKeys.add_shift.tr),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon:
                              const Icon(Icons.delete, color: AppColors.black),
                          onPressed: () {
                            showConfirmDeleteDialog(
                              title: LocaleKeys.warning.tr,
                              message: LocaleKeys
                                  .are_you_sure_you_want_to_delete_this_working_day
                                  .tr,
                              onConfirm: () => controller.removeWorkingDay(i),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ElevatedButton(
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Wrap(
                      children: [
                        for (final day in [
                          LocaleKeys.saturday.tr,
                          LocaleKeys.sunday.tr,
                          LocaleKeys.monday.tr,
                          LocaleKeys.tuesday.tr,
                          LocaleKeys.wednesday.tr,
                          LocaleKeys.thursday.tr,
                          LocaleKeys.friday.tr
                        ])
                          ListTile(
                            title: Text(day),
                            onTap: () {
                              controller.addWorkingDay(day);
                              Get.back();
                            },
                          ),
                      ],
                    ),
                  ),
                );
              },
              child: !controller.isLoading.value
                  ?  Text(LocaleKeys.add_working_day.tr)
                  : const SizedBox(
                      height: 30,
                      width: 30,
                      child: Center(child: CircularProgressIndicator())),
            ),
            const SizedBox(height: 12),

            TextButton.icon(
              onPressed: () {
                controller.fetchShifts();
                Get.toNamed(Routes
                    .DOCTOR_SHIFTS); // 👉 تأكد أنك عرّفت هذا المسار في AppPages
              },
              icon: const Icon(Icons.list_alt),
              label:  Text(LocaleKeys.view_and_edit_shifts.tr),
            ),
          ],
        ));
  }
}
