class Appointment {
  final String doctorName;
  final String specialty;
  final DateTime dateTime;
  final String location;
  final String status;

  Appointment({
    required this.doctorName,
    required this.specialty,
    required this.dateTime,
    required this.location,
    required this.status,
  });
}