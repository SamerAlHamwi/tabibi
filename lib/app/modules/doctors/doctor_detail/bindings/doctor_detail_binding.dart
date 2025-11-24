import 'package:get/get.dart';

import '../controllers/doctor_detail_controller.dart';

class DoctorsDoctorDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorsDoctorDetailController>(
      () => DoctorsDoctorDetailController(),
    );
  }
}
