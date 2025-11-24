import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app/modules/reservations/views/reservations_view.dart';

import '../../../../generated/locales.g.dart';
import '../../doctor_profile/views/doctor_profile_view.dart';
import '../../doctor_reservations/views/doctor_reservations_view.dart';
import '../../settings/views/settings_view.dart';
import '../bindings/layout_doctor_binding.dart';

class LayoutDoctorController extends GetxController {
  //TODO: Implement LayoutDoctorController
  final List<Widget> pages = const [
    ReservationsView(),
    DoctorProfileView(),
    SettingsView(),
  ];
  List<String> namePages = [LocaleKeys.reservations, LocaleKeys.profile,LocaleKeys.settings];
  List<IconData> iconPages = [Icons.article, Icons.person,Icons.settings];

  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
  final count = 0.obs;
  @override
  void onInit() {
    LayoutDoctorBinding();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
