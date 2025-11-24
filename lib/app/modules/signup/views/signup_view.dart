import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/validators.dart';
import '../../../widgets/custom_text_filde.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_add_alt_1, size: 80, color: Colors.green),
              const SizedBox(height: 16),
              Text(
                LocaleKeys.create_account.tr,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.sign_up_to_get_started.tr,
                style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              Obx(() => CustomTextField(
                    controller: controller.nameController,
                    label: LocaleKeys.name.tr,
                    validator: Validators.validateRequired,
                    prefixIcon: Icons.person_outline,
                    errorText: controller.fieldErrors.value['name'],
                  )),
              const SizedBox(height: 16),
              Obx(() => CustomTextField(
                    controller: controller.phoneNumberController,
                    label: LocaleKeys.phone_number.tr,
                    keyboardType: TextInputType.phone,
                    validator: Validators.validateEmail,
                    prefixIcon: Icons.email_outlined,
                    errorText: controller.fieldErrors['phone'],
                  )),
              const SizedBox(height: 16),
              Obx(() => CustomTextField(
                    controller: controller.passwordController,
                    label: LocaleKeys.password.tr,
                    validator: Validators.validatePassword,
                    prefixIcon: Icons.lock_outline,
                    obscureText: controller.obscurePassword.value,
                    suffixIcon: controller.obscurePassword.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onSuffixTap: controller.togglePasswordVisibility,
                  )),
              const SizedBox(height: 16),
              Obx(() => SizedBox(
                    child: CustomTextField(
                      controller: controller.confirmPasswordController,
                      label: LocaleKeys.confirm_password.tr,
                      validator: Validators.validatePassword,
                      prefixIcon: Icons.lock_outline,
                      obscureText: controller.obscurePassword.value,
                      errorText: controller.fieldErrors['password'],
                      suffixIcon: controller.obscurePassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onSuffixTap: controller.togglePasswordVisibility,
                    ),
                  )),
              const SizedBox(height: 16),
              Obx(
                () => controller.isDoctor.value
                    ? CustomTextField(
                        controller: controller.specialtyEnController,
                        label: LocaleKeys.specialty_en.tr,
                        prefixIcon: Icons.add_box_outlined,
                        errorText: controller.fieldErrors['specialty_en'],
                      )
                    : const SizedBox(),
              ),
              const SizedBox(height: 16),
              Obx(
                () => controller.isDoctor.value
                    ? CustomTextField(
                        controller: controller.specialtyArController,
                        label: LocaleKeys.specialty_ar.tr,
                        prefixIcon: Icons.add_box_outlined,
                        errorText: controller.fieldErrors['specialty_ar'],
                      )
                    : const SizedBox(),
              ),
              const SizedBox(height: 24),
              Obx(() => CheckboxListTile(
                    title: Text(LocaleKeys.are_you_a_doctor.tr),
                    value: controller.isDoctor.value,
                    onChanged: (value) {
                      controller.isDoctor.value = value!;
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  )),
              const SizedBox(height: 24),
              Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            print(
                                '********************************************');
                            controller.signup();
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Obx(() => controller.isLoading.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text('${LocaleKeys.sign_up.tr}...'),
                            ],
                          )
                        : Text(LocaleKeys.sign_up.tr)),
                  )),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.toNamed(Routes.LOGIN),
                child: Text(LocaleKeys.already_have_an_account_login.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
