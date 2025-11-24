import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../theme/app_colors.dart';
import '../../../../utils/functions.dart';
import '../controllers/doctor_detail_controller.dart';

class AvailabilityWidget extends StatelessWidget {
  final DoctorsDoctorDetailController controller = Get.put(DoctorsDoctorDetailController());

  final List<TimeOfDay> availableTimes;

  AvailabilityWidget({super.key, required this.availableTimes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                LocaleKeys.today_availability.tr,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "${availableTimes.length} ${LocaleKeys.stats.tr}",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(
            height: 100,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: .4,
              ),
              itemCount: availableTimes.length,
              itemBuilder: (context, index) {
                final time = availableTimes[index];
                final formatted = time.format(context);

                return Obx(() {
                  final isSelected = controller.selectedTime.value == time;

                  return GestureDetector(
                    onTap: () {
                      controller.selectTime(time);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.teal : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected ? Colors.teal : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          formatted,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),


          // الأوقات
          const SizedBox(height: 12)
        ],
      ),
    );
  }
}
