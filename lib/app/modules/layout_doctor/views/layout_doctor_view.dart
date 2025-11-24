import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/custom_bottom_nav_bar.dart';
import '../controllers/layout_doctor_controller.dart';

class LayoutDoctorView extends GetView<LayoutDoctorController> {
  const LayoutDoctorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: controller.pages[controller.currentIndex.value],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: controller.currentIndex.value,
        onItemTapped: controller.changePage,
        namePages: controller.namePages,
        iconPages: controller.iconPages,
      ),
    ));
  }
}
