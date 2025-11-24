import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app/data/http/app_links.dart';
import 'package:my_app/app/widgets/appbar_widget.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../data/models/doctor_models/doctor_details_response.dart';
import '../../../../data/models/doctor_models/doctors_response.dart';
import '../controllers/doctor_detail_controller.dart';
import 'buttom_wave_cilpper.dart';

class DoctorDetailWidget extends StatelessWidget {
   DoctorDetailWidget({super.key, required this.doctor});

  final DoctorData doctor;
  final DoctorsDoctorDetailController controller = Get.put(DoctorsDoctorDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: LocaleKeys.page_of_book_reservations.tr),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: BottomWaveClipper(),
              child: Container(
                height: 60,
                color: Colors.white,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  const SizedBox(height: 15),
                  Obx(() {
                    return DropdownButton<String>(
                      value: controller.selectedClinic.value,
                      hint: const Text('اختر العيادة'),
                      items: controller.clinics.map((clinic) {
                        return DropdownMenuItem(
                          value: clinic,
                          child: Text(clinic),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectClinic(value);
                        }
                      },
                    );
                  }),

                  // صف النصوص + الصورة
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ النصوص
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              doctor.name!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              doctor.specialtyEn!,
                              style:
                                  const TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            const SizedBox(height: 6),
                          SizedBox(
                            height: 65, // ارتفاع مناسب يمنع تمدد الصفحة بشكل كبير
                            child: SingleChildScrollView(
                              child: Text(
                                doctor.introduction.toString(),
                                style: const TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                          ),


                            // Text(
                            //   doctor.!,
                            //   style: const TextStyle(
                            //       fontWeight: FontWeight.bold, fontSize: 18),
                            // ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                doctor.phone!,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(width: 20),

                      Flexible(
                        flex: 1,
                        child: Image.network(
                          AppLink.imageBase + doctor.photo!,
                          width: 220,
                          height: 200,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/empty_image.jpg',
                              width: 220,
                              height: 200,
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                      )

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
