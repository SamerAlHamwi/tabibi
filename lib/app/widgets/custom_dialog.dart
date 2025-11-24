import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showConfirmationDialog({
  required String message,
  String title = 'تأكيد',
  String confirmText = 'تأكيد',
  String cancelText = 'إلغاء',
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  Get.defaultDialog(
    title: title,
    middleText: message,
    textConfirm: confirmText,
    textCancel: cancelText,
    confirmTextColor: Colors.white,
    onConfirm: () {
      Get.back(); // يغلق الـ dialog
      if (onConfirm != null) onConfirm();
    },
    onCancel: onCancel,
  );
}
