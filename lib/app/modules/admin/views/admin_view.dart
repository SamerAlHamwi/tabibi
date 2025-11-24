import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/app/widgets/appbar_widget.dart';
import '../controllers/admin_controller.dart';

class AdminView extends StatelessWidget {
  final AdminController controller = Get.put(AdminController());

  AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("إعلانات :", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Obx(() => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: controller.adsImages.asMap().entries.map((entry) {
                    int index = entry.key;
                    XFile img = entry.value;
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(img.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => controller.adsImages.removeAt(index),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close,
                                  size: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                )),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: controller.pickAdsImage,
                  icon: const Icon(Icons.add_photo_alternate),
                  label: const Text("إضافة صورة"),
                ),
                const Spacer(),
                Obx(() => ElevatedButton.icon(
                      onPressed: controller.adsImages.isEmpty ||
                              controller.addPhotoIsLoading.value
                          ? null
                          : controller.addPhoto,
                      icon: controller.addPhotoIsLoading.value
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ))
                          : const Icon(Icons.send),
                      label: const Text("نشر الصورة"),
                    )),
              ],
            ),
            const Divider(height: 40),
            const Text("إضافة مقال صحي:", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            TextField(
              onChanged: (val) => controller.articleTitleAR.value = val,
              decoration: const InputDecoration(
                labelText: "عنوان المقال باللغة العربية",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (val) => controller.articleContentAR.value = val,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: "محتوى المقال باللغة العربية",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (val) => controller.articleTitleEN.value = val,
              decoration: const InputDecoration(
                labelText: "عنوان المقال باللغة الانكليزية",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (val) => controller.articleContentEN.value = val,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: "محتوى المقال باللغة الانكليزية",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => ElevatedButton.icon(
              onPressed: controller.articleIsLoading.value
                  ? null
                  : controller.submitArticle,
              icon: controller.articleIsLoading.value
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              )
                  : const Icon(Icons.send),
              label: const Text("نشر المقال"),
            ))

          ],
        ),
      ),
    );
  }
}
