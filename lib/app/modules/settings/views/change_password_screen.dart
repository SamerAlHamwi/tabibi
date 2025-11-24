import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app/widgets/appbar_widget.dart';
import 'package:my_app/generated/locales.g.dart';

import '../../../widgets/no_internet_widget.dart';
import '../controllers/settings_controller.dart';

class ChangePasswordScreen extends GetView<SettingsController> {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: LocaleKeys.chang_password.tr,
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
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.old_password.tr,
                    prefixIcon: const Icon(Icons.lock_outline),
                    errorText: controller.fieldErrors['old_password'],
                  ),
                ),

                const SizedBox(height: 25),

                TextField(
                  controller: controller.newPasswordController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.new_password.tr,
                    prefixIcon: const Icon(Icons.lock_outline),
                    errorText: controller.fieldErrors['new_password'],
                  ),
                ),

                const SizedBox(height: 25),

                TextField(
                  controller: controller.confirmNewPasswordController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.confirm_new_password.tr,
                    prefixIcon: const Icon(Icons.lock_outline),
                    errorText: controller.fieldErrors['new_password'],
                  ),
                ),

                const SizedBox(height: 70),

                Obx(() => ElevatedButton(
                  onPressed: () async {
                    await controller.updatePassword();
                  },
                  child: controller.changePasswordIsLoading.value
                      ? const SizedBox(
                    width: 25,
                    height: 25,
                    child: Center(child: CircularProgressIndicator()),
                  )
                      :  Text(LocaleKeys.confirm_change.tr),
                )),
              ],
            ),
          ),
        );
      }),
    );
  }
}
