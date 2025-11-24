import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/services/api_service.dart';
import '../../core/storage/storage_service.dart';
import '../http/app_links.dart';
import '../models/doctor_models/generic_response.dart';
import '../models/user_models/ads_response.dart';
import '../models/user_models/artical_response.dart';

class AdminProvider {
  StorageService getStorage = StorageService();

  Future<GenericResponse> sendArticle({
    required String titleAr,
    required String titleEn,
    required String bodyAr,
    required String bodyEn,
  }) async {
    try {
      print('***********************************');
      final formData = FormData.fromMap({
        "title_ar": titleAr,
        "body_ar": bodyAr,
        "title_en": titleEn,
        "body_en": bodyEn,
        "author": "author",
      });
      final response = await DioHelper.postData(
        token: 'Bearer ${getStorage.getToken()}',
        url: AppLink.sendArticle,
        showDialogOnError: false,
        data: formData,
      );

      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<GenericResponse> addPhoto({
    required XFile imageFile,
  }) async {
    try {
      print(imageFile.path);
      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      final response = await DioHelper.postData(
        url: AppLink.sendAd,
        token: "Bearer ${getStorage.getToken()}",
        showDialogOnError: true,
        data: formData,
      );

      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<AdsResponse> getAds() async {
    try {
      final response = await DioHelper.getData(
          url: AppLink.getAds,
          token: "Bearer ${getStorage.getToken()}",
          showDialogOnError: false,
          data: {"lang": getStorage.getLanguage() ?? 'ar'});
      return AdsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<GenericResponse> deleteAd({
    required int idAd,
  }) async {
    try {
      final response = await DioHelper.deleteData(
          url: '${AppLink.getAds}/$idAd',
          token: "Bearer ${getStorage.getToken()}",
          data: {"lang": getStorage.getLanguage() ?? 'ar'});
      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<GenericResponse> deleteArticle({
    required int idArticle,
  }) async {
    try {
      final response = await DioHelper.deleteData(
          url: '${AppLink.sendArticle}/$idArticle',
          token: "Bearer ${getStorage.getToken()}",
          data: {"lang": getStorage.getLanguage() ?? 'ar'});
      return GenericResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ArticleResponse> getArticles({int? page}) async {
    try {
      final response = await DioHelper.getData(
          url: AppLink.sendArticle,
          token: "Bearer ${getStorage.getToken()}",
          showDialogOnError: false,
          data: {
            "lang": getStorage.getLanguage() ?? 'ar',
            "page": page,
          });
      return ArticleResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
