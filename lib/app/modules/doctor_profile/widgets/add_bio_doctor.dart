import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/generated/locales.g.dart';
import '../controllers/doctor_profile_controller.dart';

class DoctorBioWidget extends StatelessWidget {
  final DoctorProfileController controller = Get.find<DoctorProfileController>();

  DoctorBioWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(

          controller: controller.bioController,
          maxLines: 5,
          decoration:  InputDecoration(
            hintText: LocaleKeys.write_doctor_bio.tr,
            border: OutlineInputBorder(),
          ),
          onChanged: (val) {
            controller.bio.value = val;
          },
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            controller.saveBio();
            // Get.snackbar('تم', 'تم حفظ النبذة بنجاح');
          },
          child:  Text(LocaleKeys.confirm.tr),
        ),
      ],
    );
  }
}
