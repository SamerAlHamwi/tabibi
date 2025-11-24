import 'package:dio/dio.dart';
import 'package:my_app/app/data/http/app_links.dart';

import '../../core/services/api_service.dart';
import '../../core/storage/storage_service.dart';
import '../models/doctor_models/generic_response.dart';
import '../models/doctor_models/login_doctor_response.dart';
import '../models/user_models/auth_response_model.dart';
import '../models/user_models/registe_otp.dart';

class UserProvider {
  StorageService getStorage = StorageService();

  Future<RegisterOtp> registerUser({
    required String name,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await DioHelper.postData(
          url: AppLink.registerUser,
          showDialogOnError: false,
          data: {
            "name": name,
            "phone": phone,
            "password": password,
            "password_confirmation": passwordConfirmation,
            "rule": "user",
            "lang": getStorage.getLanguage()??'ar'
          });
      return RegisterOtp.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<RegisterOtp> registerDoctor({
    required String name,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required String specialtyEn,
    required String specialtyAr,
  }) async {
    try {
      final response = await DioHelper.postData(
          url: AppLink.registerDoctor,
          showDialogOnError: false,
          data: {
            "name": name,
            "phone": phone,
            "password": password,
            "password_confirmation": passwordConfirmation,
            "specialty_en": specialtyEn,
            "specialty_ar": specialtyAr,
            "lang":getStorage.getLanguage()??'ar'
          });
      return RegisterOtp.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthUserResponse> verificationForgetPasswordOtp({
    required String phone,
    required String otp,
    required bool isDoctor,
  }) async {
    try {
      final response = await DioHelper.postData(
          url: isDoctor
              ? AppLink.verificationOtpForgetPasswordDoctor
              : AppLink.verificationOtpForgetPasswordUser,
          showDialogOnError: false,
          data: {
            "otp": otp,
            "phone": phone,
            "lang":getStorage.getLanguage()??'ar'
          });
      return AuthUserResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<GenericResponse> sendOtoForgetPassword({
    required String phone,
    required String password,
    required String confirmPassword,
    required bool isDoctor,
  }) async {
    try {
      final response = await DioHelper.postData(
          url: isDoctor
              ? AppLink.sendForgetPasswordDoctor
              : AppLink.sendForgetPasswordUser,
          showDialogOnError: false,
          data: {
            "phone": phone,
            "password": password,
            "password_confirmation": confirmPassword,
            "lang":getStorage.getLanguage()??'ar'
          });

      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginDoctorResponse> verificationOtpDoctor({
    required String phone,
    required String otp,
  }) async {
    try {
      final response = await DioHelper.postData(
          url: AppLink.verificationOtpRegisterDoctor,
          showDialogOnError: false,
          data: {
            "otp": otp,
            "phone": phone,
            "lang":getStorage.getLanguage()??'ar'
          });
      return LoginDoctorResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthUserResponse> verificationOtpUser({
    required String phone,
    required String otp,
  }) async {
    try {
      final response = await DioHelper.postData(
          url: AppLink.verificationOtpRegisterUser,
          showDialogOnError: false,
          data: {
            "otp": otp,
            "phone": phone,
            "lang":getStorage.getLanguage()??'ar'
          });
      return AuthUserResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthUserResponse> loginUser({
    required String phone,
    required String passWord,
    required bool isDoctor,
  }) async {
    try {
      final response = await DioHelper.postData(
          url: isDoctor ? AppLink.loginDoctor : AppLink.loginUser,
          showDialogOnError: false,
          data: {
            "phone": phone,
            "password": passWord,
            "lang": getStorage.getLanguage()??'ar'
          });
      return AuthUserResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginDoctorResponse> loginDoctor({
    required String phone,
    required String passWord,
    required bool isDoctor,
  }) async {
    try {
      final response = await DioHelper.postData(
          url: AppLink.loginDoctor,
          showDialogOnError: false,
          data: {
            "phone": phone,
            "password": passWord,
            "lang":getStorage.getLanguage()??'ar'
          });
      return LoginDoctorResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> logOutUser({
    required bool isDoctor,
  }) async {
    try {
      final response = await DioHelper.postData(
          token: 'Bearer ${getStorage.getToken()}',
          url: isDoctor ? AppLink.logOutDoctor : AppLink.logOutUser,
          showDialogOnError: false,
          data: {});
      return response.data['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<GenericResponse> deleteAccount({
    required bool isDoctor,

  }) async {
    try {
      final response = await DioHelper.deleteData(

          token: 'Bearer ${getStorage.getToken()}',
          url: isDoctor ? AppLink.deleteAccountDoctor : AppLink.deleteAccountUser,
          data: {

          });
      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }


  Future<GenericResponse> changeName({
    required String nameDoctor,
    required bool typeUser,
  }) async {
    try {
      final response = await DioHelper.putData(
          token: 'Bearer ${getStorage.getToken()}',
          url: typeUser ? AppLink.updateNameDoctor : AppLink.updateNameUser,
          showDialogOnError: true,
          data: {"name": nameDoctor,"lang":getStorage.getLanguage()??'ar'});
      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<GenericResponse> changeSpecialty({
    required String arSpecialty,
    required String enSpecialty,
  }) async {
    try {
      final response = await DioHelper.putData(
          token: 'Bearer ${getStorage.getToken()}',
          url: AppLink.updateSpecialtyDoctor,
          showDialogOnError: true,
          data: {"specialty_en": enSpecialty, "specialty_ar": arSpecialty,"lang":getStorage.getLanguage()??'ar'});
      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<GenericResponse> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
    required bool typeUser,
  }) async {
    try {
      final response = await DioHelper.putData(
          token: 'Bearer ${getStorage.getToken()}',
          url: typeUser
              ? AppLink.updatePasswordDoctor
              : AppLink.updatePasswordUser,
          showDialogOnError: true,
          data: {
            "old_password": oldPassword,
            "new_password": newPassword,
            "new_password_confirmation": confirmPassword,
            "lang":getStorage.getLanguage()
          });
      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<GenericResponse> bookingReservation({
    required int idDoctor,
    required String date,
    required String time,
  }) async {
    try {
      final response = await DioHelper.postData(
          token: 'Bearer ${getStorage.getToken()}',
          url: AppLink.bookingReservation,
          showDialogOnError: true,
          data: {"doctor_id": idDoctor, "date": date, "start_time": time,"lang":getStorage.getLanguage()??'ar'});
      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<GenericResponse> deleteAppointment({
    required int idAppointment,
  }) async {
    try {
      final response = await DioHelper.postData(
          url: '${AppLink.deleteReservation}$idAppointment/cancel',
          token: 'Bearer ${getStorage.getToken()}',
          showDialogOnError: false,
          data: {});
      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
