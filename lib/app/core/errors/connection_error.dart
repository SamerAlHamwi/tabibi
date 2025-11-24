import 'package:get/get.dart';

import 'base_error.dart';


class ConnectionError extends BaseError {
  static String errorMessage = 'ConnectionError'.tr;
  String message = errorMessage;

  List<Object> get props => [];
}