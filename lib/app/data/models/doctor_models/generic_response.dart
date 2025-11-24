class GenericResponse {
  bool? success;
  String? message;
  Errors? errors;

  GenericResponse({this.success, this.message, this.errors});

  GenericResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    errors =
    json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? newPassword;

  Errors({this.newPassword});

  Errors.fromJson(Map<String, dynamic> json) {
    newPassword = json['new_password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['new_password'] = newPassword;
    return data;
  }
}
