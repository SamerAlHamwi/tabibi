import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/doctor_reservations_controller.dart';

class DoctorReservationsView extends GetView<DoctorReservationsController> {
  const DoctorReservationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DoctorReservationsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DoctorReservationsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
