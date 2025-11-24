import 'package:get/get.dart';

import 'http_error.dart';

class UnauthorizedError extends HttpError {
  String message ='Unauthorized Error'.tr;
}