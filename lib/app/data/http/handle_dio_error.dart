import 'dart:io';
import 'package:dio/dio.dart';

import '../../core/errors/bad_request_error.dart';
import '../../core/errors/base_error.dart';
import '../../core/errors/cancel_error.dart';
import '../../core/errors/conflict_error.dart';
import '../../core/errors/forbidden_error.dart';
import '../../core/errors/http_error.dart';
import '../../core/errors/internal_server_error.dart';
import '../../core/errors/net_error.dart';
import '../../core/errors/not_found_error.dart';
import '../../core/errors/socket_error.dart';
import '../../core/errors/timeout_error.dart';
import '../../core/errors/unauthorized_error.dart';
import '../../core/errors/unknown_error.dart';

BaseError handleDioError(dynamic error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutError();

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 400;
        switch (statusCode) {
          case 400:
            return BadRequestError();
          case 401:
            return UnauthorizedError();
          case 403:
            return ForbiddenError();
          case 404:
            return NotFoundError();
          case 409:
            return ConflictError();
          case 500:
            return InternalServerError();
          default:
            return HttpError();
        }

      case DioExceptionType.cancel:
        return CancelError();

      case DioExceptionType.connectionError:
        if (error.error is SocketException) {
          return SocketError();
        }
        return NetError();

      case DioExceptionType.unknown:
      default:
        return UnknownError();
    }
  } else {
    return UnknownError(); // Not a DioException at all
  }
}
