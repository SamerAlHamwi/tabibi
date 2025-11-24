import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/storage/storage_service.dart';
import '../../../data/models/doctor_models/completed_reservation_doctor.dart';
import '../../../data/models/doctor_models/completed_reversations_user.dart';
import '../../../data/models/doctor_models/generic_response.dart';
import '../../../data/models/reservations_models/reservations_model.dart';
import '../../../data/providers/reversation_provider.dart';
import '../../../data/providers/user_provider.dart';

class ReservationsController extends GetxController {
  late TabController tabController;
  var upcomingAppointments = <Appointment>[].obs;
  var pastAppointments = <Appointment>[].obs;
  var deleteAppointmentIsLoading = false.obs;
  CompletedReservationsUser completedReservationsUser =CompletedReservationsUser();
  CompletedReservationsUser lastReservationsUser =CompletedReservationsUser();

  CompletedReservationDoctor completedReservationsDoctor =CompletedReservationDoctor();
  CompletedReservationDoctor lastReservationsDoctor =CompletedReservationDoctor();
  GenericResponse genericResponse =GenericResponse();

  RxBool isConnected = true.obs;
  var isLoading = false.obs;
  StorageService getStorage = StorageService();

  Future<bool> manualCheck() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    isConnected.value = connectivityResult != ConnectivityResult.none;

    return isConnected.value;
  }

  Future<void> deleteAppointment({required int idAppointment}) async {

    await manualCheck();

    if (!isConnected.value) return;
    try {
      deleteAppointmentIsLoading.value = true;
      genericResponse = await UserProvider().deleteAppointment(
          idAppointment: idAppointment,
      );
      if(genericResponse.success == true){

        Get.snackbar('تم', genericResponse.message ?? 'تم حذف الموعد');
        fetchReservations();

      }else{
        Get.snackbar('خطأ', genericResponse.message ?? 'فشل في حذف الموعد');
      }
    } catch (e) {

    } finally {
      deleteAppointmentIsLoading.value = false;
    }
    // هنا يمكن تخزين الاسم في التخزين المحلي أو إرسال API
  }


  Future<void> fetchReservations() async {
    try {
      isLoading.value = true;
      await manualCheck();

      if (!isConnected.value) return;

      if(getStorage.getTYpeOfUser()){
        completedReservationsDoctor =  await ReservationProvider().getReservationDoctor(isComplete: true);
        lastReservationsDoctor =  await ReservationProvider().getReservationDoctor(isComplete: false);

      }else{
        completedReservationsUser =  await ReservationProvider().getReservationUser(isComplete: true);
        lastReservationsUser =  await ReservationProvider().getReservationUser(isComplete: false);

      }
         } catch (e) {
      // الخطأ تم التعامل معه مسبقًا في DioHelper
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchReservations();
  }

  void setTabController(TickerProvider vsync) {
    tabController = TabController(length: 2, vsync: vsync);
  }



  IconData getStatusIcon(int status) {
    switch (status) {
      case 1:
        return Icons.schedule;
      case 0:
        return Icons.check_circle;
      default:
        return Icons.help;
    }
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.blue;
      case 0:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
