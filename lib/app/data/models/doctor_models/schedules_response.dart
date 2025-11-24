class SchedulesResponse {
  bool? success;
  String? message;
  List<Data>? data;

  SchedulesResponse({this.success, this.message, this.data});

  SchedulesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? doctorId;
  String? dayOfWeek;
  String? startTime;
  String? endTime;
  int? reservationDuration;
  String? locationEn;
  String? locationAr;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.doctorId,
        this.dayOfWeek,
        this.startTime,
        this.endTime,
        this.reservationDuration,
        this.locationEn,
        this.locationAr,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    dayOfWeek = json['day_of_week'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    reservationDuration = json['reservation_duration'];
    locationEn = json['location_en'];
    locationAr = json['location_ar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doctor_id'] = doctorId;
    data['day_of_week'] = dayOfWeek;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['reservation_duration'] = reservationDuration;
    data['location_en'] = locationEn;
    data['location_ar'] = locationAr;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
