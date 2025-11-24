import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app/data/providers/user_provider.dart';

import '../../../core/storage/storage_service.dart';
import '../../../data/models/doctor_models/login_doctor_response.dart';
import '../../../data/models/user_models/auth_response_model.dart';
import '../../../data/models/user_models/registe_otp.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/no_internet_buttom_sheet.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final specialtyEnController = TextEditingController();
  final specialtyArController = TextEditingController();
  var obscurePassword = true.obs;
  var isDoctor = false.obs;
  var isLoading = false.obs;
  var sendVerificationCodeIsLoading = false.obs;
  var sendForgetPasswordOtpIsLoading = false.obs;
  final RxBool isError = false.obs;
  var fieldErrors = <String, String?>{}.obs;

  StorageService getStorage = StorageService();
  int? statusCode;
  final RxString code = ''.obs;
  final TextEditingController hiddenController = TextEditingController();
  final FocusNode hiddenFocusNode = FocusNode();
  RxBool isConnected = true.obs;

  Future<bool> manualCheck() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    isConnected.value = connectivityResult != ConnectivityResult.none;

    return isConnected.value;
  }
  void onTextChanged(String value) {
    if (value.length > 6) {
      value = value.substring(0, 6);
      hiddenController.text = value;
      hiddenController.selection =
          TextSelection.fromPosition(TextPosition(offset: value.length));
    }
    code.value = value;
  }

  void clear() {
    hiddenController.clear();
    code.value = '';
  }

  RegisterOtp registerUserResponse = RegisterOtp();
  AuthUserResponse registerUserResponse2 = AuthUserResponse();
  LoginDoctorResponse registerDoctorResponse2 = LoginDoctorResponse();

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void signup() async {
    await manualCheck();

    if (!isConnected.value) {
      Get.bottomSheet(
        const NoInternetBottomSheet(),
        isDismissible: true,
        enableDrag: true,
      );
      return;
    }
    fieldErrors.clear();
    try {
      isLoading.value = true;
      // استدعاء دالة التسجيل من المزود
      registerUserResponse = isDoctor.value
          ? await UserProvider().registerDoctor(
              name: nameController.text,
              phone: phoneNumberController.text,
              password: passwordController.text,
              passwordConfirmation: confirmPasswordController.text,
              specialtyAr: specialtyArController.text,
              specialtyEn: specialtyEnController.text,
            )
          : await UserProvider().registerUser(
              name: nameController.text,
              phone: phoneNumberController.text,
              password: passwordController.text,
              passwordConfirmation: confirmPasswordController.text,
            );

      if (registerUserResponse.success == true) {
        // ✅ تسجيل ناجح
        // getStorage.saveToken(registerUserResponse.data!.token!);
        // getStorage.saveTypeOfUser(isDoctor.value);

        Get.offNamed(
          Routes.VERIFICATION,
          arguments: phoneNumberController.text,
          parameters: {
            'isDoctor': '${isDoctor.value}',
            'mode': 'signup',
          },
        );

      } else if (registerUserResponse.errors != null) {
        final errorMap = registerUserResponse.errors!.toFieldMap();
        errorMap.forEach((field, messages) {
          fieldErrors[field] = messages.isNotEmpty ? messages[0] : null;
          Get.snackbar("خطأ", registerUserResponse.message ?? "فشل التسجيل");
        });
      } else {
        Get.snackbar("خطأ", registerUserResponse.message ?? "فشل التسجيل");
      }
    } catch (e) {
      print(' ******************* ');
      print(registerUserResponse.toJson());
      // معالجة أي خطأ غير متوقع
      Get.snackbar("خطأ", "حدث خطأ أثناء التسجيل: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void sendOtp({
    required String phone,
    required bool isDoctor,
  }) async {
    try {
      await manualCheck();

      if (!isConnected.value) {
        Get.bottomSheet(
          const NoInternetBottomSheet(),
          isDismissible: true,
          enableDrag: true,
        );
        return;
      }
      sendVerificationCodeIsLoading.value = true;
      // استدعاء دالة التسجيل من المزود
      print(isDoctor);
      isDoctor
          ? registerDoctorResponse2 =  await UserProvider().verificationOtpDoctor(
              otp: code.value,
              phone: phone,
            )
          :  registerUserResponse2 = await UserProvider().verificationOtpUser(
              otp: code.value,
              phone: phone,
            );

      if (registerUserResponse2.success == true || registerDoctorResponse2.success == true) {
        // ✅ تسجيل ناجح

        // تحقق من نوع المستخدم واحفظ البيانات الصحيحة
        if (isDoctor) {
          getStorage.saveToken(registerDoctorResponse2.data!.token!);
          getStorage.saveTypeOfUser(isDoctor);

          Get.offAllNamed(Routes.LAYOUT_DOCTOR);
        } else {
          getStorage.saveToken(registerUserResponse2.data!.token!);
          getStorage.saveTypeOfUser(isDoctor);

          getStorage.saveUserData(registerUserResponse2.data!.user!);
          Get.offAllNamed(Routes.LAYOUT);
        }
      }
      else if (registerUserResponse2.errors != null) {
        Get.snackbar("خطأ", registerUserResponse2.message ?? "فشل التسجيل");
      } else {
        Get.snackbar("خطأ", registerUserResponse2.message ?? "فشل التسجيل");
      }
    } catch (e) {
      print(' ******************* ');
      print(registerUserResponse2.toJson());
      // معالجة أي خطأ غير متوقع
      Get.snackbar("خطأ", "حدث خطأ أثناء التسجيل: $e");
    } finally {
      sendVerificationCodeIsLoading.value = false;
    }
  }

  void sendForgetPasswordOtp({
    required String phone,
    required bool isDoctor,
  }) async {
    try {
      await manualCheck();

      if (!isConnected.value) {
        Get.bottomSheet(
          const NoInternetBottomSheet(),
          isDismissible: true,
          enableDrag: true,
        );
        return;
      }
      sendForgetPasswordOtpIsLoading.value = true;
      // استدعاء دالة التسجيل من المزود
      registerUserResponse2 =
          await UserProvider().verificationForgetPasswordOtp(
        otp: code.value,
        phone: phone,
        isDoctor: isDoctor,
      );

      if (registerUserResponse2.success == true) {
        // ✅ تسجيل ناجح
        getStorage.saveToken(registerUserResponse2.data!.token!);
        getStorage.saveTypeOfUser(isDoctor);
        getStorage.saveUserData(registerUserResponse2.data!.user!);

        isDoctor? Get.offAllNamed(Routes.LAYOUT_DOCTOR):Get.offAllNamed(Routes.LAYOUT);
      } else if (registerUserResponse2.errors != null) {
        Get.snackbar("خطأ", registerUserResponse2.message ?? "فشل التسجيل");
      } else {
        Get.snackbar("خطأ", registerUserResponse2.message ?? "فشل التسجيل");
      }
    } catch (e) {
      print(' ******************* ');
      print(registerUserResponse2.toJson());
      // معالجة أي خطأ غير متوقع
      Get.snackbar("خطأ", "حدث خطأ أثناء التسجيل: $e");
    } finally {
      sendForgetPasswordOtpIsLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
