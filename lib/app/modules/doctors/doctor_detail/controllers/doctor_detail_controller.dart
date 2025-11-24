import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/api_service.dart';
import '../../../../core/storage/storage_service.dart';
import '../../../../data/http/app_links.dart';
import '../../../../data/models/doctor_models/avalibil_reversations_doctor.dart';
import '../../../../data/models/doctor_models/clinc_model.dart';
import '../../../../data/models/doctor_models/doctor_details_response.dart';
import '../../../../data/models/doctor_models/doctors_response.dart';
import '../../../../data/models/doctor_models/generic_response.dart';
import '../../../../data/providers/doctors_provider.dart';
import '../../../../data/providers/user_provider.dart';
import '../../../../utils/functions.dart';
import '../../../reservations/controllers/reservations_controller.dart';
import 'calendar_controller.dart';

class DoctorsDoctorDetailController extends GetxController {
  //TODO: Implement DoctorsDoctorDetailController
  var isLoading = false.obs;
  var bookingIsLoading = false.obs;
  RxBool isConnected = true.obs;

  final StorageService storage = Get.find<StorageService>();

  GenericResponse genericResponse = GenericResponse();
  final CalendarController controllerCalendar = Get.put(CalendarController());
  final ReservationsController controllerReservations =
      Get.put(ReservationsController());

  Future<bool> manualCheck() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    isConnected.value = connectivityResult != ConnectivityResult.none;

    return isConnected.value;
  }

  // الحجز الكامل من السيرفر
  var availableReservationsDoctor = AvailableReservationsDoctor().obs;

  // قائمة العيادات الخاصة بالطبيب
  var clinics = <String>[].obs;

  // العيادة المختارة حاليًا
  var selectedClinic = ''.obs;

  // الوقت المختار للحجز
  var selectedTime = Rxn<TimeOfDay>();

  // جلب المواعيد من السيرفر
  Future<void> fetchAvailableReservations({required int idDoctor}) async {
    try {
      // تحقق من الاتصال
      if (!isConnected.value) return;

      isLoading.value = true;

      availableReservationsDoctor.value =
      await DoctorsProvider().getAvailableReservations(idDoctor: idDoctor);

      // جلب قائمة العيادات بدون تكرار
      final locations = availableReservationsDoctor.value.data
          ?.map((e) => e.locationAr ?? '')
          .toSet()
          .toList() ??
          [];
      clinics.assignAll(locations);

      // افتراضيًا، اختر أول عيادة إذا موجودة
      if (clinics.isNotEmpty) selectedClinic.value = clinics.first;
    } catch (e) {
      print('Error fetching reservations: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // تغيير العيادة المختارة وتحديث المواعيد تلقائيًا
  void selectClinic(String clinic) {
    selectedClinic.value = clinic;
    selectedTime.value = null; // إلغاء الوقت المختار
  }

  // جلب المواعيد لليوم المحدد والعيادة المختارة
  List<TimeOfDay> getTimeSlotsForDate(
      List<Data> data, DateTime selectedDate) {
    final filtered = data.where((slot) {
      if (slot.slot == null) return false;

      final slotDate = DateTime.tryParse(slot.slot!);
      if (slotDate == null) return false;

      // تحقق من نفس التاريخ والعيادة
      return slotDate.year == selectedDate.year &&
          slotDate.month == selectedDate.month &&
          slotDate.day == selectedDate.day &&
          slot.locationAr == selectedClinic.value;
    }).toList();

    return filtered.map((e) {
      final dt = DateTime.parse(e.slot!);
      return TimeOfDay(hour: dt.hour, minute: dt.minute);
    }).toList();
  }

  // تحديد الوقت المختار
  void selectTime(TimeOfDay time) {
    selectedTime.value = time;
  }

  Future<void> bookingReservation({
    required int idDoctor,
  }) async {
    await manualCheck();

    if (!isConnected.value) return;
    try {
      bookingIsLoading.value = true;
      genericResponse = await UserProvider().bookingReservation(
          idDoctor: idDoctor,
          date: formatSelectedDate(controllerCalendar.selectedDate.value),
          time: formatSelectedTime(selectedTime.value!));

      if (genericResponse.success == true) {
        Get.snackbar('تم', genericResponse.message ?? 'تم حجز موعد');
        controllerReservations.fetchReservations();
      } else if (genericResponse.errors != null) {
        // 🔴 أخطاء تحقق
        genericResponse.errors!.toJson().forEach((field, messages) {});
      } else {
        Get.snackbar(
            'خطأ', genericResponse.message ?? 'فشل في تحديث كلمة السر');
      }
    } catch (e) {
    } finally {
      bookingIsLoading.value = false;
    }
    // هنا يمكن تخزين الاسم في التخزين المحلي أو إرسال API
  }



  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    final doctor = Get.arguments as DoctorData;
    fetchAvailableReservations(idDoctor: doctor.id!);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
