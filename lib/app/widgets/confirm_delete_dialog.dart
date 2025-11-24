import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/locales.g.dart';
import '../theme/app_colors.dart';

void showConfirmDeleteDialog({
  required String title,
  required String message,
  required VoidCallback onConfirm,
}) {
  Get.dialog(
    AlertDialog(
      backgroundColor: AppColors.lightGray,

      title: Text(title, style: const TextStyle(color: AppColors.primary)),
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () => Get.back(), // إغلاق النافذة
          child:  Text(LocaleKeys.cancel.tr),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back(); // إغلاق النافذة
            onConfirm(); // تنفيذ الدالة
          },
          // style: ElevatedButton.styleFrom(backgroundColor: AppColors.scaffoldBackground),
          child:  Text(LocaleKeys.delete.tr),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
