// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart' as my_dio;

import '../../data/http/app_links.dart';
import '../../data/http/handle_dio_error.dart';
import '../../widgets/error_widget.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "Accept";
const String AUTHORIZATION = "Authorization";
const String DEFAULT_LANGUAGE = "language";

class DioHelper {
  static late Dio dio;

  /// Initialize Dio
  static void init() {

    dio = Dio(
      BaseOptions(
        baseUrl: AppLink.server,
        headers: {
          CONTENT_TYPE: APPLICATION_JSON,
          ACCEPT: APPLICATION_JSON,
        },
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
      ),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
    }
  }

  /// Unified headers method
  static Map<String, String> _buildHeaders(String? token) {
    return {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      if (token != null) AUTHORIZATION: token,
    };
  }

  /// GET
  /// GET
  static Future<my_dio.Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
    VoidCallback? onRetry,
    bool showDialogOnError = true, // 👈 نفس خاصية POST
  }) async {
    dio.options.headers = _buildHeaders(token);

    print("🔵 Sending GET request to: ${dio.options.baseUrl}$url");

    try {
      final response = await dio.get(url, queryParameters: query,data: data);
      return response;
    } on DioException catch (e) {
      // ✅ إذا كانت هناك استجابة، أعدها بدون عرض نافذة الخطأ
      if (e.response != null) {
        return e.response!;
      }

      // ❌ في حال الخطأ المفاجئ
      if (false) {
        final error = handleDioError(e);
        Get.dialog(
          ErrorDisplayWidget(
            errorMessage: error.message,
            errorType: error.runtimeType,
            onRetry: () {
              Get.back();
              if (onRetry != null) onRetry();
            },
          ),
          barrierDismissible: false,
        );
      }

      rethrow;
    } catch (e) {
      if (showDialogOnError) {
        Get.dialog(
          ErrorDisplayWidget(
            errorMessage: 'حدث خطأ غير متوقع',
            errorType: 'Unknown',
            onRetry: () {
              Get.back();
              if (onRetry != null) onRetry();
            },
          ),
          barrierDismissible: false,
        );
      }
      rethrow;
    }
  }

  /// POST
  static Future<my_dio.Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
    String? token,
    VoidCallback? onRetry,
    bool showDialogOnError = true,
  }) async {
    dio.options.headers = _buildHeaders(token);

    print("🟠 Sending POST request to: ${dio.options.baseUrl}$url");

    try {
      final response = await dio.post(
        url,
        queryParameters: query,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        // ✅ نرجع الاستجابة بدلاً من رمي خطأ
        return e.response!;
      }

      if (showDialogOnError) {
        final error = handleDioError(e);
        Get.dialog(
          ErrorDisplayWidget(
            errorMessage: error.message,
            errorType: error.runtimeType,
            onRetry: () {
              Get.back();
              if (onRetry != null) onRetry();
            },
          ),
          barrierDismissible: false,
        );
      }

      // ⛔ بدل من rethrow: بإمكانك هنا إرجاع استجابة وهمية أو فارغة لو أردت
      rethrow;
    } catch (e) {
      if (showDialogOnError) {
        Get.dialog(
          ErrorDisplayWidget(
            errorMessage: 'حدث خطأ غير متوقع',
            errorType: 'Unknown',
            onRetry: () {
              Get.back();
              if (onRetry != null) onRetry();
            },
          ),
          barrierDismissible: false,
        );
      }

      rethrow;
    }
  }

  static Future<my_dio.Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
    String? token,
    VoidCallback? onRetry,
    bool showDialogOnError = true, // 👈 تحكم في ظهور ErrorDisplayWidget
  }) async {
    dio.options.headers = _buildHeaders(token);

    print("🟠 Sending PUT request to: ${dio.options.baseUrl}$url");

    try {
      final response = await dio.put(
        url,
        queryParameters: query,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      }

      if (showDialogOnError) {
        final error = handleDioError(e);
        Get.dialog(
          ErrorDisplayWidget(
            errorMessage: error.message,
            errorType: error.runtimeType,
            onRetry: () {
              Get.back();
              if (onRetry != null) onRetry();
            },
          ),
          barrierDismissible: false,
        );
      }

      rethrow;
    } catch (e) {
      if (showDialogOnError) {
        Get.dialog(
          ErrorDisplayWidget(
            errorMessage: 'حدث خطأ غير متوقع',
            errorType: 'Unknown',
            onRetry: () {
              Get.back();
              if (onRetry != null) onRetry();
            },
          ),
          barrierDismissible: false,
        );
      }
      rethrow;
    }
  }


  /// DELETE
  static Future<my_dio.Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    String? token,
  }) async {
    dio.options.headers = _buildHeaders(token);
    return await dio.delete(url, queryParameters: query, data: data);
  }
}
