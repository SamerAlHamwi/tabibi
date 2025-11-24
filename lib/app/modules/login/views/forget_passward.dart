import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app/widgets/appbar_widget.dart';
import '../../../../generated/locales.g.dart';
import '../../../utils/validators.dart';
import '../../../widgets/custom_text_filde.dart';
import '../controllers/login_controller.dart';

class ForgotPasswordView extends GetView<LoginController> {
  ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: LocaleKeys.forgot_password.tr,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // const Text("Enter your phone to reset your password"),
              const SizedBox(height: 60),
              Obx(() => CustomTextField(
                    controller: controller.phoneForgetPasswordController,
                    label: LocaleKeys.phone_number.tr,
                    errorText: controller.fieldErrors2['phone'],
                    keyboardType: TextInputType.number,
                  )),
              const SizedBox(height: 16),
              Obx(() => CustomTextField(
                    controller: controller.forgetPasswordController,
                    label: LocaleKeys.password.tr,
                    validator: Validators.validatePassword,
                    prefixIcon: Icons.lock_outline,
                    obscureText: controller.obscureForgetPassword.value,
                    errorText: controller.fieldErrors2['password'],
                    suffixIcon: controller.obscureForgetPassword.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onSuffixTap: controller.toggleForgetPasswordVisibility,
                  )),
              const SizedBox(height: 16),
              Obx(() => CustomTextField(
                    controller: controller.confirmForgetPasswordController,
                    label: LocaleKeys.confirm_password.tr,
                    validator: Validators.validatePassword,
                    prefixIcon: Icons.lock_outline,
                    obscureText: controller.obscureForgetPassword.value,
                    errorText: controller.fieldErrors2['password'],
                    suffixIcon: controller.obscureForgetPassword.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onSuffixTap: controller.toggleForgetPasswordVisibility,
                  )),
              const SizedBox(height: 24),
              Obx(() => CheckboxListTile(
                    title:  Text(LocaleKeys.are_you_a_doctor.tr,
                        style: const TextStyle(fontSize: 16)),
                    value: controller.isDoctor2.value,
                    onChanged: (value) {
                      controller.isDoctor2.value = value!;
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  )),
              const SizedBox(height: 24),
              Obx(
                    () => SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: controller.sendVerificationCodeIsLoading.value
                        ? null // ← تعطيل الزر أثناء التحميل
                        : controller.sendForgerPasswordOtp,
                    child: controller.sendVerificationCodeIsLoading.value
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        :  Text(LocaleKeys.send_reset.tr),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
