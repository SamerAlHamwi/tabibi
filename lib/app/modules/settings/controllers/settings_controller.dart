import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/storage/storage_service.dart';
import '../../../data/models/doctor_models/generic_response.dart';
import '../../../data/providers/user_provider.dart';
import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {
  //TODO: Implement SettingsController
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specialtyEgController = TextEditingController();
  final TextEditingController specialtyArController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  StorageService getStorage = StorageService();
  RxBool isDarkMode = Get.isDarkMode.obs;
  var changeNameIsLoading = false.obs;
  var deleteAccountIsLoading = false.obs;
  var changeSpecialtyIsLoading = false.obs;
  var changePasswordIsLoading = false.obs;
  var doctorName = ''.obs;
  var newPassword = ''.obs;
  RxBool isConnected = true.obs;

  var fieldErrors = <String, String?>{}.obs;
  GenericResponse genericResponse = GenericResponse();
  GenericResponse genericResponse2 = GenericResponse();
  GenericResponse genericResponse3 = GenericResponse();

  Future<bool> manualCheck() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    isConnected.value = connectivityResult != ConnectivityResult.none;

    return isConnected.value;
  }

  Future<void> updateSpecialtyDoctor() async {
    await manualCheck();

    if (!isConnected.value) return;
    try {
      changeSpecialtyIsLoading.value = true;
      genericResponse2 = await UserProvider().changeSpecialty(
          arSpecialty: specialtyArController.text,
          enSpecialty: specialtyEgController.text);
      if (genericResponse2.success == true) {
        Get.snackbar('تم', genericResponse2.message ?? 'تم تحديث الاختصاص');
        Get.offNamed(Routes.LAYOUT_DOCTOR);
      } else {
        Get.snackbar(
            'خطأ', genericResponse2.message ?? 'فشل في تحديث الاختصاص');
      }
    } catch (e) {
    } finally {
      changeSpecialtyIsLoading.value = false;
    }
    // هنا يمكن تخزين الاسم في التخزين المحلي أو إرسال API
  }

  Future<void> updateDoctorName(String newName) async {
    await manualCheck();

    if (!isConnected.value) return;
    doctorName.value = newName;
    try {
      changeNameIsLoading.value = true;
      genericResponse = await UserProvider().changeName(
          nameDoctor: doctorName.value, typeUser: getStorage.getTYpeOfUser());
      if (genericResponse.success == true) {
        Get.snackbar('تم', genericResponse.message ?? 'تم تحديث الأسم');
        // Get.offNamed(Routes.LAYOUT_DOCTOR);
      } else {
        Get.snackbar('خطأ', genericResponse.message ?? 'فشل في تحديث الأسم');
      }
    } catch (e) {
    } finally {
      changeNameIsLoading.value = false;
    }
    // هنا يمكن تخزين الاسم في التخزين المحلي أو إرسال API
  }

  Future<void> updatePassword() async {
    fieldErrors.clear();
    await manualCheck();

    if (!isConnected.value) return;
    try {
      changePasswordIsLoading.value = true;
      genericResponse = await UserProvider().changePassword(
          oldPassword: passwordController.text,
          newPassword: newPasswordController.text,
          confirmPassword: confirmNewPasswordController.text,
          typeUser: getStorage.getTYpeOfUser());

      if (genericResponse.success == true) {
        Get.snackbar('تم', genericResponse.message ?? 'تم تحديث كلمة السر');

        Get.offNamed(Routes.LAYOUT_DOCTOR);
      } else if (genericResponse.errors != null) {
        // 🔴 أخطاء تحقق
        genericResponse.errors!.toJson().forEach((field, messages) {
          fieldErrors[field] = messages.isNotEmpty ? messages[0] : null;
        });
      } else {
        Get.snackbar(
            'خطأ', genericResponse.message ?? 'فشل في تحديث كلمة السر');
      }
    } catch (e) {
    } finally {
      changePasswordIsLoading.value = false;
    }
    // هنا يمكن تخزين الاسم في التخزين المحلي أو إرسال API
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    getStorage.saveIsDarkMode(value);
    print(getStorage.getIsDarkMode());
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleLanguage() {
    final currentLang = Get.locale?.languageCode;
    print(currentLang);
    if (currentLang == 'ar') {
      Get.updateLocale(const Locale('en'));
      getStorage.saveLanguage('en');
    } else {
      Get.updateLocale(const Locale('ar'));
      getStorage.saveLanguage('ar');
    }
  }

  void contactSupport() async {
    final whatsappUrl =
        Uri.parse("https://wa.me/963988343069"); // ← غيّر الرقم حسب الحاجة
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('خطأ', 'لا يمكن فتح واتساب');
    }
  }

  Future<void> logOut() async {
    await manualCheck();

    if (!isConnected.value) return;
    try {
      changeNameIsLoading.value = true;
      await UserProvider().logOutUser(isDoctor: getStorage.getTYpeOfUser());
    } catch (e) {
      // الخطأ تم التعامل معه مسبقًا في DioHelper
    } finally {
      getStorage.deleteToken();
      Get.offAllNamed(Routes.LOGIN);
      changeNameIsLoading.value = false;
    }
  }

  Future<void> deleteAccount() async {
    await manualCheck();

    if (!isConnected.value) return;
    try {
      deleteAccountIsLoading.value = true;
      genericResponse3 = await UserProvider().deleteAccount(
          isDoctor: getStorage.getTYpeOfUser());
      if (genericResponse3.success == true) {
        Get.snackbar('تم', genericResponse.message ?? 'تم حذف الحساب بنجاح');

        getStorage.deleteToken();
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.snackbar(
            'خطأ', genericResponse.message ?? 'فشل في حذف الحساب');
      }
    } catch (e) {
      // الخطأ تم التعامل معه مسبقًا في DioHelper
    } finally {
      deleteAccountIsLoading.value = false;
    }
  }

  final count = 0.obs;

  @override
  void onInit() {
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
