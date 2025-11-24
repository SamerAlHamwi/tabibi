import 'package:get/get.dart';

import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/views/admin_tabbed_page.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/doctor_profile/bindings/doctor_profile_binding.dart';
import '../modules/doctor_profile/views/doctor_profile_view.dart';
import '../modules/doctor_profile/views/doctor_shifts_page.dart';
import '../modules/doctor_reservations/bindings/doctor_reservations_binding.dart';
import '../modules/doctor_reservations/views/doctor_reservations_view.dart';
import '../modules/doctors/bindings/doctors_binding.dart';
import '../modules/doctors/doctor_detail/bindings/doctor_detail_binding.dart';
import '../modules/doctors/doctor_detail/views/doctor_detail_view.dart';
import '../modules/doctors/views/doctors_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/layout/bindings/layout_binding.dart';
import '../modules/layout/views/layout_view.dart';
import '../modules/layout_doctor/bindings/layout_doctor_binding.dart';
import '../modules/layout_doctor/views/layout_doctor_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/forget_passward.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/reservations/bindings/reservations_binding.dart';
import '../modules/reservations/views/reservations_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/about_app_screen.dart';
import '../modules/settings/views/change_name_doctor_screen.dart';
import '../modules/settings/views/change_password_screen.dart';
import '../modules/settings/views/change_specialty_screen.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/signup/views/verification_view.dart';
import '../modules/signup/views/verification_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;
  static const LAYOUT_DOCTOR = Routes.LAYOUT_DOCTOR;
  static const LAYOUT = Routes.LAYOUT;
  static const ADMIN = Routes.ADMIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.RESERVATIONS,
      page: () => const ReservationsView(),
      binding: ReservationsBinding(),
    ),
    GetPage(
      name: _Paths.DOCTORS,
      page: () => const DoctorsView(),
      binding: DoctorsBinding(),
      children: [
        GetPage(
          name: _Paths.DOCTORS_DOCTOR_DETAIL,
          page: () => const DoctorsDoctorDetailView(),
          binding: DoctorsDoctorDetailBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LAYOUT,
      page: () => LayoutView(),
      binding: LayoutBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGETPASSWORD,
      page: () => ForgotPasswordView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.LAYOUT_DOCTOR,
      page: () => const LayoutDoctorView(),
      binding: LayoutDoctorBinding(),
    ),
    GetPage(
      name: _Paths.DOCTOR_PROFILE,
      page: () => const DoctorProfileView(),
      binding: DoctorProfileBinding(),
    ),
    GetPage(
      name: _Paths.DOCTOR_RESERVATIONS,
      page: () => const DoctorReservationsView(),
      binding: DoctorReservationsBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_NAME_DOCTOR,
      page: () => const ChangeNameDoctorScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.ABOUTABB,
      page: () => const AboutAppView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_SPECIALTY,
      page: () => const ChangeSpecialtyDoctorScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: '/doctor-shifts',
      page: () => DoctorShiftsPage(),
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => VerificationView(),
      binding: SignupBinding(),
      children: [
        GetPage(
          name: _Paths.VERIFICATION,
          page: () => VerificationView(),
          binding: SignupBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () =>  AdminTabbedPage(),
      binding: AdminBinding(),
    ),
  ];
}
