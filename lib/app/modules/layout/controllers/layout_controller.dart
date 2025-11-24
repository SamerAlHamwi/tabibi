import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../doctors/controllers/doctors_controller.dart';
import '../../doctors/views/doctors_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../../reservations/views/reservations_view.dart';
import '../../settings/views/settings_view.dart';
import '../bindings/layout_binding.dart';


class LayoutController extends GetxController {
  final List<Widget> pages = const [
    HomeView(),
    DoctorsView(),
    ReservationsView(),
    // ProfileView(),
    SettingsView(),
  ];
  var currentIndex = 0.obs;
  // مفاتيح الترجمة فقط
  final List<String> namePageKeys = [
    LocaleKeys.home,
    LocaleKeys.doctors,
    LocaleKeys.reservations,
    LocaleKeys.settings,
  ];

  List<IconData> iconPages = [Icons.home, Icons.local_hospital, Icons.article,
    // Icons.person ,
    Icons.settings];

  void changePage(int index) {
    currentIndex.value = index;
  }

  final count = 0.obs;
  @override
  void onInit() {
    LayoutBinding();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }




}
