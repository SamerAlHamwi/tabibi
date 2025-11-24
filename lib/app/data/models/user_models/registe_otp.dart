class RegisterOtp {
  bool? success;
  String? message;
  Errors? errors;

  RegisterOtp({this.success, this.message, this.errors});

  RegisterOtp.fromJson(Map<String, dynamic> json) {
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
  List<String>? phone;
  List<String>? password;
  List<String>? specialtyAr;

  Errors({this.phone, this.password, this.specialtyAr});

  Errors.fromJson(Map<String, dynamic> json) {
    phone = json['phone']?.cast<String>();
    password = json['password']?.cast<String>();
    specialtyAr = json['specialty_ar']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    data['specialty_ar'] = specialtyAr;
    return data;
  }

  /// ✅ أضف هذا التابع لتسهيل الوصول الحقل-القيمة
  Map<String, List<String>> toFieldMap() {
    final map = <String, List<String>>{};
    if (phone != null) map['phone'] = phone!;
    if (password != null) map['password'] = password!;
    if (specialtyAr != null) map['specialty_ar'] = specialtyAr!;
    return map;
  }
}
