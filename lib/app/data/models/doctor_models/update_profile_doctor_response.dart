class UpdateProfileDoctorResponse {
  bool? success;
  String? message;
  Data? data;

  UpdateProfileDoctorResponse({this.success, this.message, this.data});

  UpdateProfileDoctorResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? phone;
  String? name;
  String? specialtyEn;
  String? specialtyAr;
  String? photo;
  int? reviews;
  int? price;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.phone,
        this.name,
        this.specialtyEn,
        this.specialtyAr,
        this.photo,
        this.reviews,
        this.price,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    specialtyEn = json['specialty_en'];
    specialtyAr = json['specialty_ar'];
    photo = json['photo'];
    reviews = json['reviews'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['name'] = name;
    data['specialty_en'] = specialtyEn;
    data['specialty_ar'] = specialtyAr;
    data['photo'] = photo;
    data['reviews'] = reviews;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
