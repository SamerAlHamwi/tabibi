class AvailableReservationsDoctor {
  bool? success;
  String? message;
  List<Data>? data;

  AvailableReservationsDoctor({this.success, this.message, this.data});

  AvailableReservationsDoctor.fromJson(Map<String, dynamic> json) {
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
  String? slot;
  String? locationEn;
  String? locationAr;

  Data({this.slot, this.locationEn, this.locationAr});

  Data.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    locationEn = json['location_en'];
    locationAr = json['location_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slot'] = slot;
    data['location_en'] = locationEn;
    data['location_ar'] = locationAr;
    return data;
  }
}
