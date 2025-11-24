import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../data/models/doctor_models/avalibil_reversations_doctor.dart';
import '../../../../data/models/doctor_models/doctors_response.dart';
import '../../../../utils/functions.dart';
import '../../../../widgets/custom_dialog.dart';
import '../../../../widgets/no_internet_widget.dart';
import '../controllers/calendar_controller.dart';
import '../controllers/doctor_detail_controller.dart';
import '../widgets/avalibilty_time_doctor.dart';
import '../widgets/buttom_wave_cilpper.dart';
import '../widgets/calender_week_widget.dart';
import '../widgets/doctor_detils_widget.dart';

class DoctorsDoctorDetailView extends GetView<DoctorsDoctorDetailController> {
  const DoctorsDoctorDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doctor = Get.arguments as DoctorData;
    final CalendarController controllerCalendar = Get.put(CalendarController());

    return Scaffold(
      backgroundColor: const Color(0xFFE5F6F6),
      body: GetBuilder<DoctorsDoctorDetailController>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 425, // حدد الارتفاع المطلوب للويدجت
                child: DoctorDetailWidget(doctor: doctor),
              ),
              SizedBox(
                height: 450,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: CalendarMonthWidget(),
                ),
              ),
              SizedBox(
                height: 160,
                child: Obx(() {
                  if (!controller.isConnected.value) {
                    return NoInternetWidget(
                      onRetry: () {
                        controller.fetchAvailableReservations(idDoctor: doctor.id!);
                      },
                    );
                  }
                  if (controller.isLoading.value) {
                    // print('************************* availableReservationsDoctor **************************************');
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.availableReservationsDoctor.value.data != null &&
                      controller.availableReservationsDoctor.value.data!.isNotEmpty) {
                    final availableData = controller.getTimeSlotsForDate(
                        controller.availableReservationsDoctor.value.data!,
                        controllerCalendar.selectedDate.value);


                    if (availableData.isEmpty) {
                      return Center(
                          child: Text(LocaleKeys
                              .no_available_reservations_exist_now.tr));
                    }

                    return AvailabilityWidget(availableTimes: availableData);
                  } else {
                    return Center(
                        child: Text(
                            LocaleKeys.no_available_reservations_exist_now.tr));
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 4, left: 16, right: 16, top: 4),
                child: SizedBox(
                  width: 350,
                  height: 55,
                  child: Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                        elevation: 4,
                      ),
                      onPressed: (controller.selectedTime.value == null)
                          ? null
                          : () {
                              showConfirmationDialog(
                                  title: LocaleKeys.confirm_booking.tr,
                                  message:
                                      "${doctor.name}: ${LocaleKeys.the_appointment_will_be_confirmed_by_the_doctor.tr} \n "
                                      "${LocaleKeys.and_that_in.tr} ${formatSelectedDate(controllerCalendar.selectedDate.value)}\n"
                                      "${LocaleKeys.at_clock.tr} ${formatSelectedTime(controller.selectedTime.value!)}",
                                  confirmText: LocaleKeys.ok.tr,
                                  onConfirm: () {
                                    controller.bookingReservation(
                                      idDoctor: doctor.id!,
                                    );
                                  },
                                  onCancel: () {});

                              print('تم الضغط على زر الحجز');
                            },
                      child: Text(
                        LocaleKeys.booking_appointment.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TimeOfDay convertToTimeOfDay(String timeString) {
    List<String> parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
}
