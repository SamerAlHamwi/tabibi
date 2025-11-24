import 'dart:io';

import 'package:get_storage/get_storage.dart';
import '../../data/models/doctor_models/clinc_model.dart';
import '../../data/models/doctor_models/login_doctor_response.dart';
import '../../data/models/user_models/auth_response_model.dart';
import 'storage_keys.dart';

class StorageService {
  final GetStorage _box = GetStorage();

  // حفظ بيانات
  Future<void> saveToken(String token) async {
    await _box.write(StorageKeys.token, token);
  }
  // تخزين بيانات الطبيب
  Future<void> saveDoctorData(Doctor doctor) async {
    await _box.write(StorageKeys.doctorData, doctor.toJson());
  }

// تخزين بيانات المستخدم العادي
  Future<void> saveUserData(User user) async {
    await _box.write(StorageKeys.userData, user.toJson());
  }

  Future<void> savePhoto(String photo) async {
    await _box.write(StorageKeys.photo, photo);
  }
  Future<void> saveIsDarkMode(bool mode) async {
    await _box.write(StorageKeys.mode, mode);
  }
  Future<void> saveLanguage(String lang) async {
    await _box.write(StorageKeys.language, lang);
  }

  Future<void> saveTypeOfUser(bool isUser) async {
    await _box.write(StorageKeys.isUser, isUser);
  }
  Future<void> saveIsAdmin(bool isAdmin) async {
    await _box.write(StorageKeys.isAdmin, isAdmin);
  }
  Future<void> saveBio(String bio) async {
    await _box.write(StorageKeys.bio, bio);
  }
  Future<void> saveClinics(List<Clinic> clinics) async {
    final data = clinics.map((c) => c.toJson()).toList();
    await _box.write(StorageKeys.clinics, data);
  }



  Future<void> saveLoginState(bool loggedIn) async {
    await _box.write(StorageKeys.isLoggedIn, loggedIn);
  }
  Future<void> saveAds(List<String> ads) async {
    await _box.write(StorageKeys.ads, ads);
  }
  //حذف البيانات
  Future<void> deleteToken() async {
    await _box.remove(StorageKeys.token);
  }

  // استرجاع بيانات
  String? getToken() => _box.read(StorageKeys.token);
  String? getBio() => _box.read(StorageKeys.bio);
  List<Clinic>? getClinics() {
    final stored = _box.read(StorageKeys.clinics);
    if (stored == null) return null;

    return (stored as List)
        .map((c) => Clinic.fromJson(Map<String, dynamic>.from(c)))
        .toList();
  }

  String? getLanguage() => _box.read(StorageKeys.language);
  String? getPhotoPath() {
    final path = _box.read(StorageKeys.photo);
    if (path != null && path is String) {
      return path;
    }
    return null;
  }
  Doctor? getDoctorData() {
    final data = _box.read(StorageKeys.doctorData);
    return data != null ? Doctor.fromJson(Map<String, dynamic>.from(data)) : null;
  }

  User? getUserData() {
    final data = _box.read(StorageKeys.userData);
    return data != null ? User.fromJson(Map<String, dynamic>.from(data)) : null;
  }

  bool? getIsDarkMode() => _box.read(StorageKeys.mode);
  bool getTYpeOfUser() => _box.read(StorageKeys.isUser);
  bool getIsAdmin() => _box.read(StorageKeys.isAdmin) ?? false;
  List<dynamic> getAds() => _box.read(StorageKeys.ads) ?? [];

  bool isLoggedIn() => _box.read(StorageKeys.isLoggedIn) ?? false;

  // حذف بيانات
  Future<void> clear() async {
    await _box.erase(); // يمسح كل شيء
  }

  Future<void> remove(String key) async {
    await _box.remove(key);
  }
}
