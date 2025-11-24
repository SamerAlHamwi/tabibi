
import '../../core/services/api_service.dart';
import '../../core/storage/storage_service.dart';
import '../http/app_links.dart';
import '../models/doctor_models/completed_reservation_doctor.dart';
import '../models/doctor_models/completed_reversations_user.dart';

class ReservationProvider {

  StorageService getStorage = StorageService();

  Future<CompletedReservationsUser> getReservationUser(
      {

        String? page,
        String? per_page,
       required bool isComplete,

      }) async {
    try {
      final response = await DioHelper.getData(

          url:  AppLink.getCompleteReservationsUser,
          token: "Bearer ${getStorage.getToken()}",
          showDialogOnError: true,
          data: {
            "page":page,
            "per_page":per_page,
            "is_complete":isComplete,
            "lang":getStorage.getLanguage()??'ar'

          });
      return CompletedReservationsUser.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }




Future<CompletedReservationDoctor> getReservationDoctor(
    {

      String? page,
      String? per_page,
      required bool isComplete,


    }) async {
  try {
    final response = await DioHelper.getData(

        url:AppLink.getCompleteReservationsDoctor ,
        token: "Bearer ${getStorage.getToken()}",
        showDialogOnError: true,
        data: {
          "page":page,
          "per_page":per_page,
          "is_complete":isComplete,
          "lang":getStorage.getLanguage()??'ar'

        });
    return CompletedReservationDoctor.fromJson(response.data);
  } catch (e) {
    rethrow;
  }
}


}



