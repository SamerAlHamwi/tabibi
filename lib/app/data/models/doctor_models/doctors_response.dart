class GetDoctorsResponse {
  bool? success;
  String? message;
  DoctorsData? data;

  GetDoctorsResponse({this.success, this.message, this.data});

  GetDoctorsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? DoctorsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DoctorsData {
  List<DoctorData>? data;
  Pagination? pagination;

  DoctorsData({this.data, this.pagination});

  DoctorsData.fromJson(Map<String, dynamic> json) {
    if (json['doctors'] != null) {
      data = <DoctorData>[];
      json['doctors'].forEach((v) {
        data!.add(DoctorData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['doctors'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class DoctorData {
  int? id;
  String? phone;
  String? name;
  String? specialtyEn;
  String? specialtyAr;
  String? photo;
  String? introduction;
  int? reviews;
  String? createdAt;
  String? updatedAt;

  DoctorData({
    this.id,
    this.phone,
    this.name,
    this.specialtyEn,
    this.specialtyAr,
    this.photo,
    this.reviews,
    this.introduction,
    this.createdAt,
    this.updatedAt,
  });

  DoctorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    specialtyEn = json['specialty_en'];
    specialtyAr = json['specialty_ar'];
    photo = json['photo'];
    reviews = json['reviews'];
    introduction = json['introduction'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['phone'] = phone;
    data['name'] = name;
    data['specialty_en'] = specialtyEn;
    data['specialty_ar'] = specialtyAr;
    data['photo'] = photo;
    data['reviews'] = reviews;
    data['introduction'] = introduction;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Pagination {
  int? currentPage;
  bool? hasNext;
  bool? hasPrevious;
  int? perPage;
  int? total;
  int? lastPage;

  Pagination({
    this.currentPage,
    this.hasNext,
    this.hasPrevious,
    this.perPage,
    this.total,
    this.lastPage,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    hasNext = json['has_next'];
    hasPrevious = json['has_previous'];
    perPage = json['per_page'];
    total = json['total'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['current_page'] = currentPage;
    data['has_next'] = hasNext;
    data['has_previous'] = hasPrevious;
    data['per_page'] = perPage;
    data['total'] = total;
    data['last_page'] = lastPage;
    return data;
  }
}
