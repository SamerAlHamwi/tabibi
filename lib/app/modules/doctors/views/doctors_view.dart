import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/appbar_widget.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_text_filde.dart';
import '../../../widgets/no_internet_widget.dart';
import '../controllers/doctors_controller.dart';
import '../widgets/doctor_grid_widget.dart';

class DoctorsView extends StatefulWidget {
  const DoctorsView({Key? key}) : super(key: key);

  @override
  State<DoctorsView> createState() => _DoctorsViewState();
}

class _DoctorsViewState extends State<DoctorsView> {
  final scrollController = ScrollController();
  final DoctorsController controller = Get.put(DoctorsController());

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        if (controller.hasMore.value && !controller.isLoading.value) {
          controller.fetchDoctors();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: customAppBar(title: LocaleKeys.doctors.tr),
      body: Obx(() {
        // إذا لم يتم اختيار محافظة بعد → عرض شبكة المحافظات
        if (controller.selectedProvince.value.isEmpty) {
          return _buildProvincesGrid();
        }

        // إذا تم اختيار محافظة → عرض قائمة الأطباء مع البحث والفلترة
        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchDoctors(isRefresh: true);
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                /// 🔎 مربع البحث + زر الفلترة
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: CustomTextField(
                        controller: controller.searchController,
                        prefixIcon: Icons.search_rounded,
                        height: 0.063,
                        width: 0.77,
                        radius: 25,
                        onChanged: (value) {
                          controller.name.value = value;
                          if (value.trim().isEmpty) {
                            controller.fetchDoctors(isRefresh: true);
                          } else {
                            controller.searchDoctors(
                                name: controller.name.value,
                                location: controller.location.value);
                          }
                        },
                        label: LocaleKeys.search_for_doctor.tr,
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomIconButtonWidget(
                      size: 26,
                      icon: Icons.filter_alt_outlined,
                      onPressed: () {
                        _showFilterSheet();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                /// ✅ قائمة الأطباء
                Expanded(
                  child: Obx(() {
                    if (!controller.isConnected.value) {
                      return NoInternetWidget(
                        onRetry: () =>
                            controller.fetchDoctors(isRefresh: true),
                      );
                    }

                    if (controller.allDoctors.isEmpty &&
                        controller.isLoading.value) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }

                    if (controller.allDoctors.isEmpty) {
                      return Center(
                          child: Text(LocaleKeys.there_is_no_doctors.tr));
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: DoctorGridWidget(
                            doctors: controller.allDoctors,
                            onDoctorTap: (index) {
                              print(
                                  'تم اختيار الدكتور: ${controller.allDoctors[index].name}');
                            },
                            controller: scrollController,
                          ),
                        ),
                        if (controller.isLoading.value)
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  /// شبكة المحافظات (واجهة البداية)
  Widget _buildProvincesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // عمودين
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3,
      ),
      itemCount: controller.syrianProvinces2.length,
      itemBuilder: (context, index) {
        final province = controller.syrianProvinces2[index];
        return GestureDetector(
          onTap: () {
            controller.selectedProvince.value = province;
            controller.location.value =
            province == 'الكل' ? '' : province;

            controller.searchDoctors(
              location: controller.location.value,
              name: controller.name.value,
            );
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary),
            ),
            child: Text(
              province,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  /// فتح BottomSheet للفلترة
  void _showFilterSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: controller.syrianProvinces2.length,
            itemBuilder: (context, index) {
              final province = controller.syrianProvinces2[index];
              return ListTile(
                title: Text(province),
                onTap: () {
                  controller.selectedProvince.value = province;
                  controller.location.value =
                  province == 'الكل' ? '' : province;
                  controller.searchDoctors(
                      location: controller.location.value,
                      name: controller.name.value);
                  Navigator.pop(Get.context!);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
