import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app/theme/app_colors.dart';
import '../../../../generated/locales.g.dart';
import '../../../core/constants/constants.dart';
import '../../../data/http/app_links.dart';
import '../../../utils/functions.dart';
import '../../../widgets/appbar_widget.dart';
import '../../../widgets/confirm_delete_dialog.dart';
import '../../../widgets/custom_text_filde.dart';
import '../controllers/doctor_profile_controller.dart';
import '../widgets/add_bio_doctor.dart';
import '../widgets/clinc_weidget.dart';
import '../widgets/working_days_widget.dart';

class DoctorProfileView extends GetView<DoctorProfileController> {
  const DoctorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: customAppBar(title: LocaleKeys.doctor_profile.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            /// Section: Profile Image
            Obx(() {
              final File? imageFile = controller.profileImage.value;
              final String? imageUrl = controller.getStorage.getPhotoPath(); // استرجاع الرابط من التخزين
              final double width = SizeConfig.screenWidth;

              return Column(
                children: [
                  GestureDetector(
                    onTap: controller.pickImageSource,
                    child: Container(
                      width: width,
                      height: 250,
                      alignment: Alignment.center,
                      child: ClipOval(
                        child: SizedBox(
                          width: 250,
                          height: 250,
                          child: imageFile != null
                              ? Image.file(imageFile, fit: BoxFit.contain)
                              : (imageUrl != null && imageUrl.isNotEmpty)
                              ? Image.network(
                            AppLink.imageBase + imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) =>
                            const Icon(Icons.person, size: 60),
                          )
                              : Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.add_a_photo, size: 40, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                   Text(LocaleKeys.press_to_select_image.tr),
                ],
              );
            }),

            const SizedBox(height: 25),

            /// Section: Add Clinics
            _sectionTitle(LocaleKeys.clinics.tr),
            _buildCard([
              ClinicWidget(),
            ]),
            const SizedBox(height: 25),
            /// Section: Working Days
            _sectionTitle(LocaleKeys.working_days.tr),
            _buildCard([
              WorkingDaysWidget(),
            ]),
            const SizedBox(height: 25),

            _sectionTitle(LocaleKeys.add_bio.tr),
            _buildCard([
              DoctorBioWidget(),
            ]),


            const SizedBox(height: 25),

            /// Section: cancelSift
            _sectionTitle(LocaleKeys.cancel_shift.tr),
            _buildCard([
              ElevatedButton.icon(
                onPressed:(){
                  Get.defaultDialog(
                    title: "",
                    content: PasswordConfirmationDialog(
                      onConfirm: (value) {
                        controller.cancelShift(value);
                        print("القيمة المدخلة: $value");
                      },
                      isNumeric: false,
                      title: LocaleKeys.enter_today_date.tr,
                      labelText: "xxxx-xx-xx",
                      confirmButtonText: LocaleKeys.done.tr,
                      emptyFieldWarning: LocaleKeys.field_required.tr,
                    ),
                  );


                },
                icon: const Icon(Icons.auto_delete_outlined),
                label:  Text(LocaleKeys.add_date_to_cancel_appointments.tr),
              ),
            ]),


          ],
        ),
      ),
    );
  }

  /// Title widget for each section
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Card wrapper to wrap form sections
  Widget _buildCard(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: children,
        ),
      ),
    );
  }

}




class PasswordConfirmationDialog extends StatefulWidget {
  final Function(dynamic value) onConfirm;
  final String title;
  final String labelText;
  final String confirmButtonText;
  final String emptyFieldWarning;
  final bool isNumeric;

  PasswordConfirmationDialog({
    Key? key,
    required this.onConfirm,
    String? title,
    String? labelText,
    String? confirmButtonText,
    String? emptyFieldWarning,
    this.isNumeric = true,
  })  : title = title ?? LocaleKeys.add_date_to_cancel_appointments.tr,
        labelText = labelText ?? LocaleKeys.sessions_count.tr,
        confirmButtonText = confirmButtonText ?? LocaleKeys.confirm.tr,
        emptyFieldWarning = emptyFieldWarning ?? LocaleKeys.please_enter_value.tr,
        super(key: key);


  @override
  _PasswordConfirmationDialogState createState() => _PasswordConfirmationDialogState();
}

class _PasswordConfirmationDialogState extends State<PasswordConfirmationDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.title, textAlign: TextAlign.center),
        const SizedBox(height: 10),
        TextField(
          controller: _controller,
          keyboardType: widget.isNumeric ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget.labelText,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            final input = _controller.text;
            if (input.isEmpty) {
              Get.snackbar(LocaleKeys.warning.tr, widget.emptyFieldWarning);
              return;
            }

            if (widget.isNumeric) {
              final int? value = int.tryParse(input);
              if (value == null) {
                Get.snackbar("خطأ", "الرجاء إدخال رقم صحيح");
                return;
              }
              widget.onConfirm(value);
            } else {
              widget.onConfirm(input);
            }

            Get.back(); // إغلاق الـ Dialog
          },
          child: Text(widget.confirmButtonText),
        ),
      ],
    );
  }
}
