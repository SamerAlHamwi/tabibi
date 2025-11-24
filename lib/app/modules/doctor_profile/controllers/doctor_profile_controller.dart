import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app/utils/functions.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/storage/storage_service.dart';
import '../../../data/models/doctor_models/clinc_model.dart';
import '../../../data/models/doctor_models/generic_response.dart';
import '../../../data/models/doctor_models/schedules_response.dart'
    as schedules;
import '../../../data/models/doctor_models/update_profile_doctor_response.dart';
import '../../../data/models/doctor_models/working_day.dart';
import '../../../data/providers/doctors_provider.dart';
import '../../../widgets/no_internet_buttom_sheet.dart';


class DoctorProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cancelDateController = TextEditingController();
  late TextEditingController bioController;
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController sessionDurationController =
      TextEditingController();
  final TextEditingController priceSessionController = TextEditingController();
  StorageService getStorage = StorageService();

  var bio = ''.obs;
  var name = ''.obs;
  var specialization = ''.obs;
  var phoneNumbers = <String>[].obs;
  var sessionDuration = ''.obs;
  var consultationFee = ''.obs;
  var currentCity = ''.obs;
  var currentGovernorate = ''.obs;
  GenericResponse genericResponse = GenericResponse();
  GenericResponse genericResponse2 = GenericResponse();
  GenericResponse genericResponse3 = GenericResponse();
  GenericResponse genericResponse4 = GenericResponse();
  GenericResponse genericResponse5 = GenericResponse();
  var isLoading = false.obs;
  var getScheduleIsLoading = false.obs;
  var schedulesIsLoading = false.obs;
  var addPhotoIsLoading = false.obs;
  var lockButton = true.obs;
  var selectedDay = '';

  final count = 0.obs;
  var profileImageUrl = RxnString(); // ⬅️ نضيف متغير للرابط

  RxList<WorkingDay> workingDays = <WorkingDay>[].obs;
  var workingSchedule = <String, List<Map<String, String>>>{}.obs;
  RxMap<String, List<schedules.Data>> groupedShifts =
      <String, List<schedules.Data>>{}.obs;

  UpdateProfileDoctorResponse updateProfileDoctorResponse =
      UpdateProfileDoctorResponse();

  void addPhoneNumber() => phoneNumbers.add('');

  void removePhoneNumber(int index) =>
      phoneNumbers.length == 1 ? null : phoneNumbers.removeAt(index);
  var profileImage = Rxn<File>(); // صورة الملف

  final List<String> syrianGovernorates = [
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
    'الرقة',
    'الحسكة',
    'إدلب'
  ];
  final Map<String,String> days = {
    "السبت": "saturday",
    "الأحد": "sunday", "الاثنين": "monday",
    "الثلاثاء": "tuesday",
    "الأربعاء": "wednesday",
    "الخميس": "thursday",
    "الجمعة": "friday",

    "Saturday": "saturday",
    "Sunday": "sunday",
    "Monday": "monday",
    "Tuesday": "tuesday",
    "Wednesday": "wednesday",
    "Thursday": "thursday",
    "Friday": "friday",
  };
  final selectedGovernorate = RxnString();
  final addressController = RxString('');
  final clinics = <Clinic>[].obs;
  final selectedClinic = Rxn<Clinic>();
  RxBool isConnected = true.obs;

  Future<bool> manualCheck() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    isConnected.value = connectivityResult != ConnectivityResult.none;

    return isConnected.value;
  }
  Future<void> saveBio() async {
    await manualCheck();

    if (!isConnected.value) {
      Get.bottomSheet(
        const NoInternetBottomSheet(),
        isDismissible: true,
        enableDrag: true,
      );
      return;
    }

    // هنا تضيف منطق حفظ النبذة، مثلا إرسالها للسيرفر أو تخزين محلي
    genericResponse5 = await DoctorsProvider().addBioDoctor(bio: bio.value);
    if (genericResponse5.success == true) {
      getStorage.saveBio(bio.value);

      Get.snackbar("تم", genericResponse5.message ?? "تم إضافة نبذة بنجاح");
    } else {
      Get.snackbar("خطأ", genericResponse5.message ?? "تعذر إضافة نبذة");
    }
    print('Saved bio: ${bio.value}');
  }


  void addClinic() {
    if (selectedGovernorate.value != null &&
        addressController.value.trim().isNotEmpty) {
      final newClinic = Clinic(
        governorate: selectedGovernorate.value!,
        address: addressController.value.trim(),
      );
      clinics.add(newClinic);
      selectedClinic.value = newClinic; // اختر العيادة المضافة تلقائيًا
      getStorage.saveClinics(clinics);

      // Reset
      selectedGovernorate.value = null;
      addressController.value = '';
    }
  }

  /// اختيار صورة من الكاميرا أو الاستوديو أو الملفات
  Future<void> pickImageSource() async {
    await Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("اختر من الاستوديو"),
              onTap: () async {
                Get.back();
                final picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  profileImage.value = File(image.path);
                  addPhoto();
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text("اختر من الملفات"),
              onTap: () async {
                Get.back();
                final result =
                    await FilePicker.platform.pickFiles(type: FileType.image);
                if (result != null && result.files.single.path != null) {
                  profileImage.value = File(result.files.single.path!);
                  addPhoto();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addPhoto() async {
    try {
      await manualCheck();

      if (!isConnected.value) {
        Get.bottomSheet(
          const NoInternetBottomSheet(),
          isDismissible: true,
          enableDrag: true,
        );
        return;
      }
      addPhotoIsLoading.value = true;
      genericResponse2 =
          await DoctorsProvider().addPhoto(imageFile: profileImage.value!);
      if (genericResponse2.success == true) {
        Get.snackbar('تم', genericResponse2.message ?? 'تم رفع الصورة');
        getStorage.savePhoto(profileImage.value!.path);
      } else {
        Get.snackbar('خطأ', genericResponse2.message ?? 'فشل في رفع الصورة');
      }
    } finally {
      print(profileImage.value);

      addPhotoIsLoading.value = false;
    }
  }

  void addWorkingDay(String day) {
    workingDays.add(WorkingDay(day: day, shifts: [Schedule()]));
  }

  void addShiftToDay(int dayIndex) {
    workingDays[dayIndex].shifts.add(Schedule());
    workingDays.refresh();
  }

  void removeShift(int dayIndex, int shiftIndex) {
    workingDays[dayIndex].shifts.removeAt(shiftIndex);
    if (workingDays[dayIndex].shifts.isEmpty) {
      removeWorkingDay(dayIndex);
    } else {
      workingDays.refresh();
    }
  }

  void pickTime(int dayIndex, int shiftIndex, bool isStart) async {
    final picked = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      if (isStart) {
        workingDays[dayIndex].shifts[shiftIndex].from = picked;
      } else {
        workingDays[dayIndex].shifts[shiftIndex].to = picked;
      }
      workingDays.refresh();
    }
  }

  void removeWorkingDay(int index) {
    workingDays.removeAt(index);
  }

  Future<void> fetchShifts() async {
    await manualCheck();

    if (!isConnected.value) {
      Get.bottomSheet(
        const NoInternetBottomSheet(),
        isDismissible: true,
        enableDrag: true,
      );
      return;
    }
    getScheduleIsLoading.value = true;

    try {
      // ✅ لا حاجة لتحويل يدوي من JSON، فهو كائن جاهز
      final schedulesResponse = await DoctorsProvider().getDoctorShifts();
      final allShifts = schedulesResponse.data ?? [];

      final Map<String, List<schedules.Data>> grouped = {};
      for (final shift in allShifts) {
        final day = shift.dayOfWeek?.toLowerCase();
        if (day == null) continue;
        grouped.putIfAbsent(day, () => []).add(shift);
      }

      groupedShifts.value = grouped;
      print("✅ groupedShifts: ${groupedShifts.value}");
    } catch (e, st) {
      print("❌ حدث خطأ أثناء تحميل النوبات: $e");
      print("📍 Stack trace: $st");
      Get.snackbar("خطأ", "فشل في تحميل النوبات");
    } finally {
      getScheduleIsLoading.value = false;
    }
  }

  Future<void> deleteShift(int id) async {
    await manualCheck();

    if (!isConnected.value) {
      Get.bottomSheet(
        const NoInternetBottomSheet(),
        isDismissible: true,
        enableDrag: true,
      );
      return;
    }
    genericResponse3 = await DoctorsProvider().deleteDoctorShift(id: id);
    if (genericResponse3.success == true) {
      await fetchShifts(); // تحديث القائمة بعد الحذف
      Get.snackbar("تم الحذف", "تم حذف النوبة بنجاح");
    }
  }

  Future<void> cancelShift(String date) async {
    await manualCheck();

    if (!isConnected.value) {
      Get.bottomSheet(
        const NoInternetBottomSheet(),
        isDismissible: true,
        enableDrag: true,
      );
      return;
    }
    try{
      genericResponse4 = await DoctorsProvider().cancelDoctorShift(date: date);
      if (genericResponse4.success == true) {

        Get.snackbar("تم الحذف", "تم إلغاء النوبة بنجاح");
      }else{
        Get.snackbar("خطأ", "تعذر إلغاء النوبة");
      }
    }catch(e,st){
      Get.snackbar("خطأ", "تعذر إلغاء النوبة");
    }

  }

  Future<void> addSchedules(
      int dayIndex, int shiftIndex, int reservationDuration) async {
    await manualCheck();

    if (!isConnected.value) {
      Get.bottomSheet(
        const NoInternetBottomSheet(),
        isDismissible: true,
        enableDrag: true,
      );
      return;
    }
    try {
      schedulesIsLoading.value = true;

      final shift = workingDays[dayIndex].shifts[shiftIndex];
      if (shift.from != null && shift.to != null) {
        final selectedDay = days[workingDays[dayIndex].day]; // هذا يعمل الآن
        print("selectedDay");
        print(selectedDay);
        genericResponse = await DoctorsProvider().addSchedulesDoctors(
          dayOfWeek: selectedDay!,
          startTime: formatTimeOfDay(shift.from!),
          endTime: formatTimeOfDay(shift.to!),
          reservationDuration: reservationDuration,
          locationAr: '${selectedClinic.value!.governorate} - ${selectedClinic.value!.address}' ,
          locationEn: '${selectedClinic.value!.governorate} - ${selectedClinic.value!.address}',
        );
      }

      if (genericResponse.success == true) {
        Get.snackbar('تم', genericResponse.message ?? 'تم اضافة النوبة بنجاح');

        lockButton.value = true;
      } else if (genericResponse.errors != null) {
        // 🔴 أخطاء تحقق
        print(genericResponse.errors!.toJson());
        genericResponse.errors!.toJson().forEach((field, messages) {
          print(messages.toString());
          Get.snackbar('خطأ', messages ?? 'فشل في اضافة النوبة');
        });
      } else {
        Get.snackbar('خطأ', genericResponse.message ?? 'فشل في اضافة النوبة');
      }
    } catch (e) {
      print('***************************************************************');
      print(genericResponse.success.toString());

      Get.snackbar('خطأ', genericResponse.message ?? 'فشل في اضافة النوبة');

      // الخطأ تم التعامل معه مسبقًا في DioHelper
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile({required String password}) async {
    await manualCheck();

    if (!isConnected.value) {
      Get.bottomSheet(
        const NoInternetBottomSheet(),
        isDismissible: true,
        enableDrag: true,
      );
      return;
    }
    try {
      isLoading.value = true;
      updateProfileDoctorResponse = await DoctorsProvider().updateProfile(
        nameDoctor: nameController.text,
        phone: phoneNumbers.first,
        specialty: specializationController.text,
        price: int.parse(priceSessionController.text),
        oldPassword: password,
      );
    } catch (e) {
      // الخطأ تم التعامل معه مسبقًا في DioHelper
    } finally {
      isLoading.value = false;
    }
  }

  void updateWorkingDay(String day, List<Map<String, String>> slots) {
    workingSchedule[day] = slots;
  }


  void saveProfile(String password) {
    // Save data logic here
    print("Saving profile with name: ${name.value}");
  }

  @override
  void onInit() {
    bioController = TextEditingController();
    final saved = getStorage.getPhotoPath();
    if (saved != null) {
      print(
          '****************************** saved ************************************************');
      print(saved);
      profileImageUrl.value = saved; // حفظ الرابط هنا فقط
    }
    final savedBio = getStorage.getBio();
    if (savedBio != null) {
      print(
          '****************************** saved ************************************************');
      print(savedBio);
      bio.value = savedBio; // حفظ الرابط هنا فقط
      bioController.text = savedBio;
    }
    final savedClinics = getStorage.getClinics();
    if (savedClinics != null) {
      print(
          '****************************** saved ************************************************');
      print(savedClinics);
      clinics.value = savedClinics; // حفظ الرابط هنا فقط
    }


    // مزامنة النص الموجود في الكونترولر مع المتغير التفاعلي
    bioController.addListener(() {
      bio.value = bioController.text;
    });
    phoneNumbers.add('');
    super.onInit();
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
