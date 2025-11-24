import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/storage/storage_service.dart';
import '../../../data/models/doctor_models/doctors_response.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/card_doctor_widget.dart';
import '../../../core/constants/constants.dart';

class DoctorGridWidget extends StatelessWidget {
  final List<DoctorData> doctors;
  final void Function(int doctor)? onDoctorTap;
  final ScrollController? controller; // ✅ إضافة ScrollController

  const DoctorGridWidget({
    Key? key,
    required this.doctors,
    this.onDoctorTap,
    this.controller, // ✅ تمرير اختياري
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StorageService getStorage = StorageService();

    SizeConfig.init(context);
    return GridView.builder(
      controller: controller, // ✅ تمرير الكونترولر
      padding: const EdgeInsets.all(0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        DoctorData doctor = doctors[index];
        return GestureDetector(
          child: DoctorCardWidget(
            imageUrl: doctor.photo ?? '',
            name: doctor.name ?? '',
            specialty: getStorage.getLanguage() == 'ar'
                ? doctor.specialtyAr ?? ''
                : doctor.specialtyEn ?? '',
            reviews: doctor.reviews ?? 0,
            onTap: () {
              if (onDoctorTap != null) {
                onDoctorTap!(index ?? 0);
              }
              Get.toNamed(Routes.DOCTORS_DOCTOR_DETAIL, arguments: doctor);
            },
          ),
          onTap: () {
            if (onDoctorTap != null) {
              onDoctorTap!(index ?? 0);
            }
            Get.toNamed(Routes.DOCTORS_DOCTOR_DETAIL, arguments: doctor);
          },
        );
      },
    );
  }
}
