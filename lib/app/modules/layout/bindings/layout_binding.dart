import 'package:get/get.dart';
import 'package:my_app/app/modules/doctors/controllers/doctors_controller.dart';
import 'package:my_app/app/modules/home/controllers/home_controller.dart';
import 'package:my_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:my_app/app/modules/reservations/controllers/reservations_controller.dart';

import '../../settings/controllers/settings_controller.dart';
import '../controllers/layout_controller.dart';

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorsController>(
          () => DoctorsController(), fenix: true
    );
    Get.lazyPut<LayoutController>(
      () => LayoutController(), fenix: true
    );

    Get.lazyPut<ReservationsController>(
          () => ReservationsController(), fenix: true
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(), fenix: true
    );
    Get.lazyPut<HomeController>(
          () => HomeController(), fenix: true
    );
    Get.lazyPut<SettingsController>(
            () => SettingsController(), fenix: true
    );
  }
}
