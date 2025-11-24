import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_app/app/data/http/app_links.dart';

import '../../core/services/api_service.dart';
import '../../core/storage/storage_service.dart';
import '../models/doctor_models/avalibil_reversations_doctor.dart';
import '../models/doctor_models/doctors_response.dart';
import '../models/doctor_models/generic_response.dart';
import '../models/doctor_models/schedules_response.dart';
import '../models/doctor_models/update_profile_doctor_response.dart';

class DoctorsProvider {

  StorageService getStorage = StorageService();

  Future<GetDoctorsResponse> getDoctors(
      {
         int? page,
         int? per_page,

      }) async {
    try {
      final response = await DioHelper.getData(

          url: AppLink.getDoctors,
          token: "Bearer ${getStorage.getToken()}",
          showDialogOnError: false,
          data: {
            "page":page,
            "per_page":per_page,
            "lang":getStorage.getLanguage()??'ar'

          });
      return GetDoctorsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<GetDoctorsResponse> searchDoctors(
      {

        required String name,
        required String location,
         String? page,
         String? per_page,

      }) async {
    try {
      final response = await DioHelper.getData(

          url: AppLink.searchDoctors,
          token: "Bearer ${getStorage.getToken()}",
          showDialogOnError: true,
          data: {
            "name":name,
            "location_ar":location,
            "page":page,
            "per_page":per_page,
            "lang":getStorage.getLanguage()??'ar'

          });
      return GetDoctorsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }


  Future<GenericResponse> addSchedulesDoctors(
      {

       required String dayOfWeek,
       required String startTime,
       required String endTime,
       required int reservationDuration,
       required String locationEn,
       required String locationAr,

      }) async {
    try {
      final response = await DioHelper.postData(

          url: AppLink.addSchedulesDoctor,
          token: "Bearer ${getStorage.getToken()}",
          showDialogOnError: true,
          data: {
            "day_of_week": dayOfWeek,
            "start_time": startTime,
            "end_time": endTime,
            "reservation_duration": reservationDuration,
            "location_en":locationEn,
            "location_ar":locationAr,
            "lang":getStorage.getLanguage()??'ar'
          });
      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }



  Future<AvailableReservationsDoctor> getAvailableReservations(
      {
        required int idDoctor,
        String? page,
        String? per_page,

      }) async {
    try {
      final response = await DioHelper.getData(

          url: "${AppLink.getAvailableReservationsUser}/$idDoctor/availability",
          token: "Bearer ${getStorage.getToken()}",
          showDialogOnError: true,
          data: {

              "week":4,
            "lang":getStorage.getLanguage()??'ar'
          });
      return AvailableReservationsDoctor.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<UpdateProfileDoctorResponse> updateProfile(
      {
        required String nameDoctor,
        required String phone,
        required String specialty,
        required int price,
        required String oldPassword,
      }) async {
    try {
      final response = await DioHelper.putData(

          url: AppLink.updateDoctor,
          token: "Bearer ${getStorage.getToken()}",

          data: {
            "name": nameDoctor,
            "phone": phone,
            // "specialty_en": "Cardiologist",
            "specialty_ar": specialty,
            "price": price,
            "old_password": oldPassword,
            "lang":getStorage.getLanguage()??'ar'
            // "new_password": "123123",
            // "new_password_confirmation": "123123"

          });
      return UpdateProfileDoctorResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }


  Future<GenericResponse> addPhoto({
    required File imageFile,

  }) async {
    try {
      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),

      });

      final response = await DioHelper.postData(
        url: AppLink.addPhotoDoctor,
        token: "Bearer ${getStorage.getToken()}", // تحقق من اسم المفتاح
        showDialogOnError: true,
        data: formData,
      );

      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }


  Future<SchedulesResponse> getDoctorShifts(
      {

        String? page,
        String? per_page,

      }) async {
    try {
      final response = await DioHelper.getData(

          url: AppLink.getSchedulesResponse,
          token: "Bearer ${getStorage.getToken()}",
          showDialogOnError: true,
          data: {

          });
      return SchedulesResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }


  Future<GenericResponse> deleteDoctorShift(
      {

       required int id,

      }) async {
    try {
      final response = await DioHelper.deleteData(

          url: '${AppLink.deleteSchedulesResponse}/$id}',
          token: "Bearer ${getStorage.getToken()}",
          data: {

          });
      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }


  Future<GenericResponse> addBioDoctor(
      {

        required String bio,

      }) async {
    try {
      final response = await DioHelper.putData(

          url: AppLink.addBioDoctor,
          token: "Bearer ${getStorage.getToken()}",
          data: {
            "introduction":bio,
            "lang":getStorage.getLanguage()??'ar'

          });
      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }


  Future<GenericResponse> cancelDoctorShift(
      {

       required String date,

      }) async {
    try {
      final response = await DioHelper.deleteData(
          url: AppLink.deleteByDaySchedulesResponse,
          token: "Bearer ${getStorage.getToken()}",
          data: {
            "date":date,
            "lang":getStorage.getLanguage()??'ar'
          });
      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }


}


