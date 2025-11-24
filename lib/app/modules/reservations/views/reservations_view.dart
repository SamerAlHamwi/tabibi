import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../generated/locales.g.dart';
import '../../../core/storage/storage_service.dart';
import '../../../data/models/doctor_models/avalibil_reversations_doctor.dart';
import '../../../data/models/doctor_models/completed_reservation_doctor.dart';
import '../../../data/models/doctor_models/completed_reversations_user.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/confirm_delete_dialog.dart';
import '../../../widgets/no_internet_widget.dart';
import '../controllers/reservations_controller.dart';
import '../../../data/models/reservations_models/reservations_model.dart';

class ReservationsView extends StatefulWidget {
  const ReservationsView({Key? key}) : super(key: key);

  @override
  State<ReservationsView> createState() => _ReservationsViewState();
}

class _ReservationsViewState extends State<ReservationsView>
    with SingleTickerProviderStateMixin {
  final ReservationsController controller = Get.put(ReservationsController());
  StorageService getStorage = StorageService();

  @override
  void initState() {
    super.initState();
    controller.setTabController(this);
  }

  @override
  void dispose() {
    controller.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(LocaleKeys.reservations.tr),
        bottom: TabBar(
          controller: controller.tabController,
          tabs:  [
            Tab(text: LocaleKeys.current_reservations.tr),
            Tab(text:LocaleKeys.last_reservations.tr),
          ],
        ),
      ),
      body: Obx(() {
        if (!controller.isConnected.value) {
          return NoInternetWidget(
            onRetry: () {
              controller.fetchReservations();
            },
          );
        }

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return TabBarView(
            controller: controller.tabController,
            children: [
              if (getStorage.getTYpeOfUser())
                RefreshIndicator(
                  onRefresh: controller.fetchReservations,
                  child: buildAppointmentsListDoctor(
                      controller.lastReservationsDoctor),
                ),
              if (getStorage.getTYpeOfUser())
                RefreshIndicator(
                  onRefresh: controller.fetchReservations,
                  child: buildAppointmentsListDoctor(
                      controller.completedReservationsDoctor),
                ),
              if (!getStorage.getTYpeOfUser())
                RefreshIndicator(
                  onRefresh: controller.fetchReservations,
                  child: buildAppointmentsList(
                      controller.lastReservationsUser),
                ),
              if (!getStorage.getTYpeOfUser())
                RefreshIndicator(
                  onRefresh: controller.fetchReservations,
                  child: buildAppointmentsList(
                      controller.completedReservationsUser),
                ),
            ],
          );

    }),
    );
  }

  Widget buildAppointmentCard(ReversationUserItem appointment) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(appointment.doctor!.name!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appointment.doctor!.specialtyEn!),
            Text(appointment.startTime!.split('.')[0]),
            Text(appointment.date!),
            Text(appointment.locationEn!),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  controller.getStatusIcon(appointment.isComplete!),
                  color: controller.getStatusColor(appointment.isComplete!),
                ),
                const SizedBox(height: 4),
                Text(
                  appointment.isComplete == 1 ? LocaleKeys.completed.tr : LocaleKeys.un_completed.tr,
                  style: TextStyle(
                    color: controller.getStatusColor(appointment.isComplete!),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: LocaleKeys.delete_appointment.tr,
              onPressed: () {
                showConfirmDeleteDialog(
                  title: LocaleKeys.warning.tr,
                  message: LocaleKeys.do_you_sure_for_this_action.tr,
                  onConfirm: (){
                    controller.deleteAppointment(idAppointment: appointment.id!);
                  }
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppointmentCardDoctor(Reservations appointment) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(appointment.user?.name ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appointment.user?.phone ?? ''),
            Text(appointment.date!),
            Text(appointment.startTime!.split('.')[0]),
            Text(appointment.locationEn!),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(controller.getStatusIcon(appointment.isComplete!),
                color: controller.getStatusColor(appointment.isComplete!)),
            const SizedBox(height: 4),
            Text(
              appointment.isComplete == 1 ? LocaleKeys.completed.tr : LocaleKeys.un_completed.tr,
              style: TextStyle(
                  color: controller.getStatusColor(appointment.isComplete!),
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppointmentsList(CompletedReservationsUser appointments) {
    if (appointments.data == null) {
      return  Center(child: Text(LocaleKeys.there_is_no_reservation.tr));
    }
    if (appointments.data!.data!.isEmpty) {
      return  Center(child: Text(LocaleKeys.there_is_no_reservation.tr));
    }
    return ListView.builder(
      itemCount: appointments.data!.data!.length,
      itemBuilder: (context, index) =>
          buildAppointmentCard(appointments.data!.data![index]),
    );
  }

  Widget buildAppointmentsListDoctor(CompletedReservationDoctor appointments) {
    if (appointments.data == null) {
      return  Center(child: Text(LocaleKeys.there_is_no_reservation.tr));
    }
    if (appointments.data!.reservations!.isEmpty) {
      return  Center(child: Text(LocaleKeys.there_is_no_reservation.tr));
    }
    return ListView.builder(
      itemCount: appointments.data!.reservations!.length,
      itemBuilder: (context, index) =>
          buildAppointmentCardDoctor(appointments.data!.reservations![index]),
    );
  }
}
