class CompletedReservationsUser {
  bool? success;
  String? message;
  ReversationsUserData? data;

  CompletedReservationsUser({this.success, this.message, this.data});

  CompletedReservationsUser.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ReversationsUserData.fromJson(json['data']) : null;
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

class ReversationsUserData {
  List<ReversationUserItem>? data;
  Pagination? pagination;

  ReversationsUserData({this.data, this.pagination});

  ReversationsUserData.fromJson(Map<String, dynamic> json) {
    if (json['reservations'] != null) {
      data = <ReversationUserItem>[];
      json['reservations'].forEach((v) {
        data!.add(ReversationUserItem.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['reservations'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class ReversationUserItem {
  int? id;
  int? doctorId;
  String? startTime;
  String? date;
  String? locationEn;
  String? locationAr;
  int? isComplete;
  String? createdAt;
  String? updatedAt;
  Doctor? doctor;

  ReversationUserItem({
    this.id,
    this.doctorId,
    this.startTime,
    this.date,
    this.locationEn,
    this.locationAr,
    this.isComplete,
    this.createdAt,
    this.updatedAt,
    this.doctor,
  });

  ReversationUserItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    startTime = json['start_time'];
    date = json['date'];
    locationEn = json['location_en'];
    locationAr = json['location_ar'];
    isComplete = json['is_complete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['doctor_id'] = doctorId;
    data['start_time'] = startTime;
    data['date'] = date;
    data['location_en'] = locationEn;
    data['location_ar'] = locationAr;
    data['is_complete'] = isComplete;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    return data;
  }
}

class Doctor {
  int? id;
  String? phone;
  String? name;
  String? specialtyEn;
  String? specialtyAr;
  String? photo;
  int? reviews;
  String? createdAt;
  String? updatedAt;

  Doctor({
    this.id,
    this.phone,
    this.name,
    this.specialtyEn,
    this.specialtyAr,
    this.photo,
    this.reviews,
    this.createdAt,
    this.updatedAt,
  });

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    specialtyEn = json['specialty_en'];
    specialtyAr = json['specialty_ar'];
    photo = json['photo'];
    reviews = json['reviews'];
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
