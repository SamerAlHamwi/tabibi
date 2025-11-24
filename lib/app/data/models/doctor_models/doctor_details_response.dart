class DoctorDetailsResponse {
  Doctor? doctor;

  DoctorDetailsResponse({this.doctor});

  DoctorDetailsResponse.fromJson(Map<String, dynamic> json) {
    doctor =
    json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    return data;
  }
}

class Doctor {
  int? id;
  String? name;
  String? specialization;
  String? profileImage;
  WorkingSchedule? workingSchedule;
  Location? location;
  String? clinicName;
  int? consultationFee;

  Doctor(
      {this.id,
        this.name,
        this.specialization,
        this.profileImage,
        this.workingSchedule,
        this.location,
        this.clinicName,
        this.consultationFee});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    specialization = json['specialization'];
    profileImage = json['profileImage'];
    workingSchedule = json['workingSchedule'] != null
        ? WorkingSchedule.fromJson(json['workingSchedule'])
        : null;
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    clinicName = json['clinicName'];
    consultationFee = json['consultationFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['specialization'] = specialization;
    data['profileImage'] = profileImage;
    if (workingSchedule != null) {
      data['workingSchedule'] = workingSchedule!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['clinicName'] = clinicName;
    data['consultationFee'] = consultationFee;
    return data;
  }
}

class WorkingSchedule {
  List<String>? sunday;
  List<String>? monday;
  List<String>? tuesday;
  List<String>? wednesday;
  List<String>? thursday;

  WorkingSchedule(
      {this.sunday, this.monday, this.tuesday, this.wednesday, this.thursday});

  WorkingSchedule.fromJson(Map<String, dynamic> json) {
    sunday = json['sunday'].cast<String>();
    monday = json['monday'].cast<String>();
    tuesday = json['tuesday'].cast<String>();
    wednesday = json['wednesday'].cast<String>();
    thursday = json['thursday'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sunday'] = sunday;
    data['monday'] = monday;
    data['tuesday'] = tuesday;
    data['wednesday'] = wednesday;
    data['thursday'] = thursday;
    return data;
  }
}

class Location {
  String? city;
  String? area;
  String? address;

  Location({this.city, this.area, this.address});

  Location.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    area = json['area'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['area'] = area;
    data['address'] = address;
    return data;
  }
}
