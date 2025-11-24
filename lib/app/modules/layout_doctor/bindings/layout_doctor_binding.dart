import 'package:get/get.dart';
import 'package:my_app/app/modules/doctor_reservations/controllers/doctor_reservations_controller.dart';
import 'package:my_app/app/modules/settings/controllers/settings_controller.dart';

import '../../doctor_profile/controllers/doctor_profile_controller.dart';
import '../controllers/layout_doctor_controller.dart';

class LayoutDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(
            () => SettingsController(), fenix: true
    );
    Get.lazyPut<DoctorReservationsController>(
            () => DoctorReservationsController(), fenix: true
    );
    Get.lazyPut<DoctorProfileController>(
            () => DoctorProfileController(), fenix: true
    );
    Get.lazyPut<LayoutDoctorController>(
      () => LayoutDoctorController(), fenix: true
    );
  }
}
