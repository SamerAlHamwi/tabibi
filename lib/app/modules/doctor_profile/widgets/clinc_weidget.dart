import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/generated/locales.g.dart';

import '../../../widgets/confirm_delete_dialog.dart';
import '../../doctors/doctor_detail/controllers/doctor_detail_controller.dart';
import '../controllers/doctor_profile_controller.dart';

class ClinicWidget extends StatelessWidget {
  final DoctorProfileController controller = Get.put(DoctorProfileController());

   ClinicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textFieldController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.add_location_alt),
          label:  Text(LocaleKeys.add_clinic.tr),
          onPressed: () {
            Get.bottomSheet(
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: controller.selectedGovernorate.value,
                      decoration:
                       InputDecoration(labelText: LocaleKeys.choose_governorate.tr),
                      items: controller.syrianGovernorates
                          .map((gov) => DropdownMenuItem(
                        value: gov,
                        child: Text(gov),
                      ))
                          .toList(),
                      onChanged: (val) {
                        controller.selectedGovernorate.value = val;
                      },
                    )),
                    const SizedBox(height: 12),
                    Obx(() {
                      textFieldController.text = controller.addressController.value;
                      textFieldController.selection = TextSelection.fromPosition(
                          TextPosition(offset: textFieldController.text.length));
                      return TextFormField(
                        controller: textFieldController,
                        decoration:
                         InputDecoration(labelText: LocaleKeys.detailed_address.tr),
                        onChanged: (val) {
                          controller.addressController.value = val;
                        },
                      );
                    }),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        controller.addClinic();
                        // print(controller.clinics.first.governorate);
                        // print(controller.clinics.first.address);
                        Get.back(); // إغلاق الـ BottomSheet
                      },
                      child:  Text(LocaleKeys.save.tr),
                    )
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Obx(() => controller.clinics.isEmpty
            ?  Text(LocaleKeys.no_clinics_added.tr)
            : ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.clinics.length,
          itemBuilder: (context, index) {
            final clinic = controller.clinics[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: Text('${clinic.governorate} - ${clinic.address}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showConfirmDeleteDialog(
                      title: LocaleKeys.warning.tr,
                      message: LocaleKeys.do_you_sure_for_this_action.tr,
                      onConfirm:()=> controller.clinics.removeAt(index),

                    );

                  },
                ),
              ),
            );
          },
        )),

      ],
    );
  }
}
