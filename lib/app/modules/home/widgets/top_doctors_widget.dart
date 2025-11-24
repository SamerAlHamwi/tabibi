// import 'package:flutter/material.dart';
//
// class TopDoctorsWidget extends StatelessWidget {
//   // final List<Doctors> topDoctors;
//
//   TopDoctorsWidget({required this.topDoctors});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             'Top Doctors',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//         SizedBox(height: 10),
//         SizedBox(
//           height: 200, // ارتفاع عنصر البطاقة
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: topDoctors.map((doctor) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: DoctorCard(doctor: doctor),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class DoctorCard extends StatelessWidget {
//   final Doctors doctor;
//
//   DoctorCard({required this.doctor});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 150,
//       height: 150,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const ClipRRect(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//             child: CircleAvatar(
//               backgroundImage: AssetImage('assets/images/image.png'),
//               radius: 24,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             doctor.name!,
//             style: TextStyle(fontWeight: FontWeight.bold),
//             textAlign: TextAlign.center,
//           ),
//           Text(
//             doctor.specialty!,
//             style: TextStyle(color: Colors.grey[600]),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
