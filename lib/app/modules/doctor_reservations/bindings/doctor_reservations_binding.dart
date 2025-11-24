import 'package:get/get.dart';

import '../controllers/doctor_reservations_controller.dart';

class DoctorReservationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorReservationsController>(
      () => DoctorReservationsController(),
    );
  }
}
