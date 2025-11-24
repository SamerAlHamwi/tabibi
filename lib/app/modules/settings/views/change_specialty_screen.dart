import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app/widgets/appbar_widget.dart';
import 'package:my_app/generated/locales.g.dart';
import '../controllers/settings_controller.dart';

class ChangeSpecialtyDoctorScreen extends GetView<SettingsController> {
  const ChangeSpecialtyDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: customAppBar(
        title: LocaleKeys.chang_specialty.tr,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 150,),
              TextField(
                controller: controller.specialtyArController,
                decoration:  InputDecoration(
                    labelText:  LocaleKeys.specialty_ar.tr,
                    prefixIcon: const Icon(Icons.add_box)
                  // border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30,),
              TextField(
                controller: controller.specialtyEgController,
                decoration:  InputDecoration(
                    labelText:  LocaleKeys.specialty_en.tr,
                    prefixIcon: const Icon(Icons.add_box)
                  // border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 70),
              Obx(()=>
                  ElevatedButton(
                    onPressed: () async {
                      final arSpecialty = controller.specialtyArController.text.trim();
                      final enSpecialty = controller.specialtyEgController.text.trim();
                      if (enSpecialty.isNotEmpty && arSpecialty.isNotEmpty) {
                        await controller.updateSpecialtyDoctor();

                      } else {
                        Get.snackbar( LocaleKeys.error.tr,  LocaleKeys.please_enter_valid_name.tr);
                      }
                    },
                    child: controller.changeSpecialtyIsLoading.value ? const SizedBox(width: 25,height: 25, child: Center(child: CircularProgressIndicator())): const Text('تأكيد التغيير'),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
