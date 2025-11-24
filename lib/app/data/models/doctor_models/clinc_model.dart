class Clinic {
  final String governorate;
  final String address;

  Clinic({required this.governorate, required this.address});

  Map<String, dynamic> toJson() {
    return {
      'governorate': governorate,
      'address': address,
    };
  }

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      governorate: json['governorate'] ?? '',
      address: json['address'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Clinic &&
              runtimeType == other.runtimeType &&
              governorate == other.governorate &&
              address == other.address;

  @override
  int get hashCode => governorate.hashCode ^ address.hashCode;
}
