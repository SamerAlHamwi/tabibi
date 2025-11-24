import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../data/http/app_links.dart';
import '../../../data/models/doctor_models/doctors_response.dart';
import '../../../data/providers/doctors_provider.dart';

class DoctorsController extends GetxController {
  //TODO: Implement DoctorsController
  late final TextEditingController searchController;

  GetDoctorsResponse getDoctorsResponse =GetDoctorsResponse();
  final List<String> syrianProvinces = [
    'دمشق',
    'ريف دمشق',
    'حلب',
    'حمص',
    'حماة',
    'اللاذقية',
    'طرطوس',
    'إدلب',
    'درعا',
    'القنيطرة',
    'السويداء',
    'دير الزور',
    'الرقة',
    'الحسكة',
  ];
  final List<String> syrianProvinces2 = [
    'الكل',
    'دمشق',
    'ريف دمشق',
    'حلب',
    'حمص',
    'حماة',
    'اللاذقية',
    'طرطوس',
    'درعا',
    'السويداء',
    'القنيطرة',
    'دير الزور',
    'الحسكة',
    'الرقة',
  ];


  RxString selectedProvince = ''.obs;
  RxString name = ''.obs;
  RxString location = ''.obs;
  RxBool isConnected = true.obs;
  var page = 1.obs;
  var hasMore = true.obs;
  List<DoctorData> allDoctors = [];

  final count = 0.obs;
  var isLoading = false.obs;



  Future<bool> manualCheck() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    isConnected.value = connectivityResult != ConnectivityResult.none;

    return isConnected.value;
  }

  //
  // void filterByProvince(String province) {
  //   if (province.isEmpty) {
  //     // إذا لم يتم اختيار محافظة، ارجع كل الأطباء
  //     getDoctorsResponse.data?.data = allDoctors;
  //   } else {
  //     final filtered = allDoctors.where((d) => d.province == province).toList();
  //     getDoctorsResponse.data?.data = filtered;
  //   }
  //   update(); // لتحديث الواجهة
  // }



  @override
  void onInit() {
    manualCheck();
    // fetchDoctors(isRefresh: false);
    searchController = TextEditingController();
    super.onInit();
  }


  Future<void> fetchDoctors({bool isRefresh = false}) async {
    await manualCheck();
    if (!isConnected.value) return;

    try {
      if (isRefresh) {
        page.value = 1;
        hasMore.value = true;
        allDoctors.clear();
      }

      isLoading.value = true;

      final response = await DoctorsProvider().getDoctors(page: page.value);

      final fetchedDoctors = response.data?.data ?? [];

      if (fetchedDoctors.isNotEmpty) {
        allDoctors.addAll(fetchedDoctors);
        page.value++;
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      print("حدث خطأ: $e");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> searchDoctors({String? name, String? location}) async {
    try {
      await manualCheck();
      if (!isConnected.value) return;

      isLoading.value = true;
      if (location == 'الكل') {
        location = '';
      }

      final response = await DoctorsProvider()
          .searchDoctors(name: name ?? '', location: location ?? '');

      // فضي القائمة القديمة
      allDoctors.clear();

      // عبّي القائمة بالنتائج الجديدة
      final fetchedDoctors = response.data?.data ?? [];
      allDoctors.addAll(fetchedDoctors);

      // وقف التحميل
      hasMore.value = false; // لأنو بحث مش Pagination
    } catch (e) {
      print("خطأ بالبحث: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
