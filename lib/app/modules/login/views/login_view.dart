import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/validators.dart';
import '../../../widgets/custom_text_filde.dart';
import '../controllers/login_controller.dart';
import '../../../../generated/locales.g.dart';

class LoginView extends GetView<LoginController> {
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

              Image.asset(
                'assets/icons/icon_app2.jpg',
                width: 220,
                height: 220,
                // fit: BoxFit.fill,
              ),

              // const SizedBox(height: 16),
              Text(
                LocaleKeys.welcome_back.tr,
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.login_to_continue.tr,
                style:
                    theme.textTheme.titleMedium?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 32),
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
                    errorText: controller.fieldErrors['password'],
                    suffixIcon: controller.obscurePassword.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onSuffixTap: controller.togglePasswordVisibility,
                  )),
              const SizedBox(height: 24),
              Obx(() => CheckboxListTile(
                    title: Text(LocaleKeys.login_as_doctor.tr),
                    value: controller.isDoctor.value,
                    onChanged: (value) {
                      controller.isDoctor.value = value!;
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  )),

              const SizedBox(height: 24),
              Obx(() => ElevatedButton(
                    onPressed:
                        controller.isLoading.value ? null : controller.login,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Obx(() => controller.isLoading.value
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(LocaleKeys.login.tr)),
                  )),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {

                  Get.toNamed(Routes.FORGETPASSWORD);
                },
                child:  Text(LocaleKeys.forgot_password_question.tr),
              ),
              TextButton(
                onPressed: () => Get.toNamed(Routes.SIGNUP),
                child: Text(LocaleKeys.dont_have_an_account_sign_up.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
