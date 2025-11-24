import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/app/data/models/doctor_models/generic_response.dart';

import '../../../core/storage/storage_service.dart';
import '../../../data/models/doctor_models/login_doctor_response.dart';
import '../../../data/models/user_models/auth_response_model.dart';
import '../../../data/providers/user_provider.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/no_internet_buttom_sheet.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  late final TextEditingController phoneNumberController;
  late final TextEditingController passwordController;
  TextEditingController phoneForgetPasswordController = TextEditingController();
  TextEditingController forgetPasswordController = TextEditingController();
  TextEditingController confirmForgetPasswordController =
      TextEditingController();

  AuthUserResponse loginUserResponse = AuthUserResponse();
  LoginDoctorResponse loginDoctorResponse = LoginDoctorResponse();
  StorageService getStorage = StorageService();
  GenericResponse genericResponse = GenericResponse();
  final count = 0.obs;
  var obscurePassword = true.obs;
  var obscureForgetPassword = true.obs;
  var isLoading = false.obs;
  var isDoctor = false.obs;
  var isDoctor2 = false.obs;
  var sendVerificationCodeIsLoading = false.obs;

  var fieldErrors = <String, String?>{}.obs;
  var fieldErrors2 = <String, String?>{}.obs;
  RxBool isConnected = true.obs;

  Future<bool> manualCheck() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    isConnected.value = connectivityResult != ConnectivityResult.none;

    return isConnected.value;
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleForgetPasswordVisibility() {
    obscureForgetPassword.value = !obscureForgetPassword.value;
  }

  @override
  void onInit() {
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void login() async {
    await manualCheck();

    if (!isConnected.value) {
      Get.bottomSheet(
        const NoInternetBottomSheet(),
        isDismissible: true,
        enableDrag: true,
      );
      return;
    }
    try {
      isLoading.value = true;
      fieldErrors.clear();
      // التحقق من نوع المستخدم
      if (isDoctor.value) {
        loginDoctorResponse = await UserProvider().loginDoctor(
          phone: phoneNumberController.text,
          passWord: passwordController.text,
          isDoctor: isDoctor.value,
        );

        if (loginDoctorResponse.success == true) {
          final token = loginDoctorResponse.data?.token;
          final photo = loginDoctorResponse.data?.doctor?.photo ?? '';
          final doctor = loginDoctorResponse.data?.doctor;

          // ✅ حفظ البيانات
          getStorage.saveDoctorData(doctor!);
          getStorage.saveToken(token!);
          getStorage.saveTypeOfUser(true);
          getStorage.savePhoto(photo); // حفظ رابط الصورة فقط كسلسلة نصية
          print(
              '******************************************************************************');
          print(photo);

          Get.offAllNamed(Routes.LAYOUT_DOCTOR);
        } else if (loginUserResponse.errors != null) {
          // 🔴 أخطاء تحقق
          loginUserResponse.errors!.forEach((field, messages) {
            fieldErrors[field] = messages.isNotEmpty ? messages[0] : null;
          });
        } else {
          Get.snackbar(
              "خطأ", loginDoctorResponse.message ?? "فشل تسجيل الدخول");
        }
      } else {
        loginUserResponse = await UserProvider().loginUser(
          phone: phoneNumberController.text,
          passWord: passwordController.text,
          isDoctor: false,
        );

        if (loginUserResponse.success == true) {
          final token = loginUserResponse.data?.token;
          final user = loginUserResponse.data?.user;

          // ✅ حفظ البيانات
          getStorage.saveUserData(user!);
          getStorage.saveToken(token!);
          getStorage.saveTypeOfUser(false);
          if (loginUserResponse.data?.user?.rule == 'admin') {
            getStorage.saveIsAdmin(true);

            Get.offAllNamed(Routes.ADMIN);
          } else {
            getStorage.saveIsAdmin(false);

            Get.offAllNamed(Routes.LAYOUT);
          }
        } else if (loginUserResponse.errors != null) {
          // 🔴 أخطاء تحقق
          loginUserResponse.errors!.forEach((field, messages) {
            fieldErrors[field] = messages.isNotEmpty ? messages[0] : null;
          });
        } else {
          Get.snackbar("خطأ", loginUserResponse.message ?? "فشل تسجيل الدخول");
        }
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء تسجيل الدخول");
    } finally {
      isLoading.value = false;
    }
  }

  void sendForgerPasswordOtp() async {
    await manualCheck();

    if (!isConnected.value) {
      Get.bottomSheet(
        const NoInternetBottomSheet(),
        isDismissible: true,
        enableDrag: true,
      );
      return;
    }
    try {
      sendVerificationCodeIsLoading.value = true;
      // استدعاء دالة التسجيل من المزود
      genericResponse = await UserProvider().sendOtoForgetPassword(
        phone: phoneForgetPasswordController.text.trim(),
        password: forgetPasswordController.text,
        confirmPassword: confirmForgetPasswordController.text,
        isDoctor: isDoctor2.value,
      );

      if (genericResponse.success == true) {
        Get.toNamed(
          Routes.VERIFICATION,
          arguments: phoneForgetPasswordController.text,
          parameters: {
            'isDoctor': '${isDoctor2.value}',
            'mode': 'forgetPassword',
          },
        );
      } else if (genericResponse.errors != null) {
        // genericResponse.errors!.forEach((field, messages) {
        //   fieldErrors2[field] = messages.isNotEmpty ? messages[0] : null;
        // });
      } else {
        Get.snackbar("خطأ", genericResponse.message ?? "فشل التسجيل");
      }
    } catch (e) {
      print(' ******************* ');
      print(genericResponse.toJson());
      // معالجة أي خطأ غير متوقع
      Get.snackbar("خطأ", "حدث خطأ أثناء التسجيل: $e");
    } finally {
      print(' ******************* ');
      print(genericResponse.toJson());
      sendVerificationCodeIsLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
