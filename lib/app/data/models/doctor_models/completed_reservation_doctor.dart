class CompletedReservationDoctor {
  bool? success;
  String? message;
  Data? data;

  CompletedReservationDoctor({this.success, this.message, this.data});

  CompletedReservationDoctor.fromJson(Map<String, dynamic> json) {
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
  List<Reservations>? reservations;
  Pagination? pagination;

  Data({this.reservations, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['reservations'] != null) {
      reservations = <Reservations>[];
      json['reservations'].forEach((v) {
        reservations!.add(Reservations.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reservations != null) {
      data['reservations'] = reservations!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Reservations {
  int? id;
  int? userId;
  String? startTime;
  String? date;
  String? locationEn;
  String? locationAr;
  int? isComplete;
  String? createdAt;
  String? updatedAt;
  User? user;

  Reservations(
      {this.id,
        this.userId,
        this.startTime,
        this.date,
        this.locationEn,
        this.locationAr,
        this.isComplete,
        this.createdAt,
        this.updatedAt,
        this.user});

  Reservations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    startTime = json['start_time'];
    date = json['date'];
    locationEn = json['location_en'];
    locationAr = json['location_ar'];
    isComplete = json['is_complete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['start_time'] = startTime;
    data['date'] = date;
    data['location_en'] = locationEn;
    data['location_ar'] = locationAr;
    data['is_complete'] = isComplete;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? phone;
  String? rule;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.phone,
        this.rule,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    rule = json['rule'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['rule'] = rule;
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

  Pagination(
      {this.currentPage,
        this.hasNext,
        this.hasPrevious,
        this.perPage,
        this.total,
        this.lastPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    hasNext = json['has_next'];
    hasPrevious = json['has_previous'];
    perPage = json['per_page'];
    total = json['total'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['has_next'] = hasNext;
    data['has_previous'] = hasPrevious;
    data['per_page'] = perPage;
    data['total'] = total;
    data['last_page'] = lastPage;
    return data;
  }
}
