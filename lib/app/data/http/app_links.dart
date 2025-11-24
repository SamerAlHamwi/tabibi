


class AppLink {
  // static const String server = "https://doctor-app.free.beeceptor.com";
  // static const String getDoctors = "/get_doctors";
  //
  static const String server = "https://api.doctorme.site/api/my-doctor/";
  static const String imageBase = "https://api.doctorme.site/storage/";

  //Auth
  static const String registerUser = "auth/register/otp/send"; // فقط المسار
  static const String registerDoctor = "doctor-auth/register/otp/send"; // فقط المسار
  static const String verificationOtpRegisterDoctor = "doctor-auth/register/otp/verify"; // فقط المسار
  static const String verificationOtpRegisterUser = "auth/register/otp/verify"; // فقط المسار
  static const String verificationOtpForgetPasswordUser = "auth/forgot-password/verify"; // فقط المسار
  static const String verificationOtpForgetPasswordDoctor = "doctor-auth/forgot-password/verify"; // فقط المسار
  static const String sendForgetPasswordUser = "auth/forgot-password/request"; // فقط المسار
  static const String sendForgetPasswordDoctor = "doctor-auth/forgot-password/request"; // فقط المسار
  static const String loginUser = "auth/login"; // فقط المسار
  static const String loginDoctor = "doctor-auth/login"; // فقط المسار
  static const String logOutUser = "auth/logout"; // فقط المسار
  static const String logOutDoctor = "doctor-auth/logout"; // فقط المسار

  //User
  static const String getDoctors = "user/get-doctors"; // فقط المسار
  static const String getAvailableReservationsUser = "user/reservations/"; // فقط المسار
  static const String getCompleteReservationsUser = "user/reservations/"; // فقط المسار
  static const String updateNameUser = "user/update-name";
  static const String updatePasswordUser = "user/update-password";
  static const String bookingReservation = "user/reservations/book";
  static const String deleteReservation = "user/reservations/";
  static const String searchDoctors = "user/doctors/search";
  static const String deleteAccountUser = "user/delete";
  //Doctor
  static const String getCompleteReservationsDoctor = "doctor/reservations/"; // فقط المسار
  static const String updateDoctor = "doctor/update-doctor"; // فقط المسار
  static const String updateNameDoctor = "doctor/update-name"; // فقط المسار
  static const String updateSpecialtyDoctor = "doctor/update-specialty"; // فقط المسار
  static const String updatePasswordDoctor = "doctor/update-password"; // فقط المسار
  static const String addSchedulesDoctor = "doctor/schedules/"; // فقط المسار
  static const String addPhotoDoctor = "doctor/upload-image"; // فقط المسار
  static const String getSchedulesResponse = "doctor/schedules/";
  static const String deleteSchedulesResponse = "doctor/schedules/";
  static const String addBioDoctor = "doctor/update-doctor";
  static const String deleteByDaySchedulesResponse = "doctor/reservations/delete-by-day";
  static const String deleteAccountDoctor = "doctor/delete";
  //Admin
  static const String sendArticle = "admin/articles/";
  static const String sendAd = "admin/ads/";
  static const String getAds = "admin/ads/";


}