import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../generated/locales.g.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/confirm_delete_dialog.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings.tr),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(LocaleKeys.chang_name.tr),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              controller.doctorName.value = '';
              Get.toNamed(Routes.CHANGE_NAME_DOCTOR);
            },
          ),
          // ListTile(
          //
          //   leading: const Icon(Icons.phone),
          //   title: const Text('تغيير الرقم'),
          //   trailing: const Icon(Icons.arrow_forward_ios),
          //   onTap: controller.toggleLanguage,
          // ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: Text(LocaleKeys.chang_password.tr),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              controller.fieldErrors.clear();
              Get.toNamed(Routes.CHANGE_PASSWORD);
            },
          ),
          controller.getStorage.getTYpeOfUser()
              ? ListTile(
                  leading: const Icon(Icons.add_box),
                  title: Text(LocaleKeys.chang_specialty.tr),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => Get.toNamed(Routes.CHANGE_SPECIALTY),
                )
              : const SizedBox(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.swap_horiz),
            title: Text(LocaleKeys.change_language.tr),
            trailing: const Icon(Icons.language),
            onTap: controller.toggleLanguage,
          ),
          // Obx(() => SwitchListTile(
          //   secondary: const Icon(Icons.dark_mode),
          //   title:  Text(LocaleKeys.dark_mode.tr),
          //   value: controller.isDarkMode.value,
          //   onChanged: controller.toggleDarkMode,
          // )),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(LocaleKeys.about.tr),
            onTap: () => Get.toNamed(Routes.ABOUTABB),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: const Icon(Icons.headset_mic),
            title: Text(LocaleKeys.support.tr),
            onTap: controller.contactSupport,
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(LocaleKeys.logout.tr,
                style: const TextStyle(color: Colors.red)),
            onTap: controller.logOut,
            trailing: const Icon(Icons.arrow_forward_ios),
          ),

          ListTile(
            leading:
                const Icon(Icons.delete_forever_outlined, color: Colors.red),
            title: Text(
              LocaleKeys.delete_account.tr,
              style: const TextStyle(color: Colors.red),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              showConfirmDeleteDialog(
                title:LocaleKeys.delete_account.tr,
                message: LocaleKeys.confirm_delete_account.tr,
                onConfirm: controller.deleteAccount
              );
            },
          )
        ],
      ),
    );
  }
}

void showDeleteAccountForm({
  required Function(String phone, String password) onConfirm,
}) {

  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      title: const Text(
        "تأكيد حذف الحساب",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("إلغاء"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {},
          child: const Text("حذف الحساب"),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
