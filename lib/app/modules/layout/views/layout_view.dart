import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/layout_controller.dart';
import '../../../widgets/custom_bottom_nav_bar.dart'; // ← تأكد من المسار الصحيح

class LayoutView extends GetView<LayoutController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: controller.pages[controller.currentIndex.value],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: controller.currentIndex.value,
        onItemTapped: controller.changePage,
        namePages: controller.namePageKeys,  // تمرير المفاتيح وليس النصوص المترجمة
        iconPages: controller.iconPages,
      ),
    ));
  }
}
