import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app/widgets/appbar_widget.dart';
import 'package:my_app/generated/locales.g.dart';
import '../../../widgets/no_internet_widget.dart';
import '../controllers/settings_controller.dart';

class ChangeNameDoctorScreen extends GetView<SettingsController> {
  const ChangeNameDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: customAppBar(
        title: LocaleKeys.chang_name.tr,
        centerTitle: true,
      ),
      body: Obx(() {
      if (!controller.isConnected.value) {
        return NoInternetWidget(
          onRetry: () {
            controller.manualCheck(); // إعادة المحاولة
          },
        );
      }

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 150),
              TextField(
                controller: controller.nameController,
                decoration:  InputDecoration(
                  labelText: LocaleKeys.new_name.tr,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 70),
              Obx(() => ElevatedButton(
                onPressed: () async {
                  final newName = controller.nameController.text.trim();
                  if (newName.isNotEmpty) {
                    await controller.updateDoctorName(newName);
                  } else {
                    Get.snackbar( LocaleKeys.error.tr,  LocaleKeys.please_enter_valid_name.tr);
                  }
                },
                child: controller.changeNameIsLoading.value
                    ? const SizedBox(
                    width: 25,
                    height: 25,
                    child: Center(child: CircularProgressIndicator()))
                    :  Text( LocaleKeys.confirm_change.tr),
              )),
            ],
          ),
        ),
      );
    }),
    );
  }
}
