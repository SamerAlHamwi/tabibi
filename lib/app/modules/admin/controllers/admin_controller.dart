import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/app/data/providers/admin_provider.dart';

import '../../../core/storage/storage_service.dart';
import '../../../data/models/doctor_models/generic_response.dart';
import '../../../data/models/user_models/ads_response.dart';
import '../../../data/models/user_models/artical_response.dart';
import '../../../data/providers/user_provider.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/no_internet_buttom_sheet.dart';

class AdminController extends GetxController {
  //TODO: Implement AdminController

  final RxList<XFile>   adsImages = <XFile>[].obs;
  final RxList<String> adsImages2 = <String>[].obs;
  RxList<Article> articles = <Article>[].obs;

  final RxString articleTitleAR = ''.obs;
  final RxString articleTitleEN = ''.obs;
  final RxString articleContentAR = ''.obs;
  final RxString articleContentEN = ''.obs;
  var articleIsLoading = false.obs;
  var addPhotoIsLoading = false.obs;
  var getAdsIsLoading = false.obs;
  var getArticlesIsLoading = false.obs;
  var deleteAdIsLoading = false.obs;
  var deleteArticleIsLoading = false.obs;
  StorageService getStorage = StorageService();

  GenericResponse genericResponse2 = GenericResponse();
  ArticleResponse articleResponse = ArticleResponse();
  ScrollController scrollController = ScrollController();

  GenericResponse genericResponse = GenericResponse();
  GenericResponse genericResponse3 = GenericResponse();
  AdsResponse adsResponse =AdsResponse();
  final ImagePicker _picker = ImagePicker();
  RxBool isConnected = true.obs;
  int currentPage = 1;
  int lastPage = 1;
  RxBool isFetchingMore = false.obs;



  Future<void> pickAdsImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      adsImages.clear(); // إذا كنت تريد صورة واحدة فقط، امسح القائمة القديمة
      adsImages.add(picked);
    }
  }

  Future<void> fetchAds() async {
    await manualCheck();

    if (!isConnected.value) return;

    try {
      getAdsIsLoading.value = true;
      adsResponse = await AdminProvider().getAds();

      if (adsResponse.data != null) {
        // استخراج الصور وتحويلها إلى روابط كاملة
        adsImages2.value = adsResponse.data!
            .map((e) => "https://api.doctorme.site/storage/${e.photo}")
            .toList();
        getStorage.saveAds(adsImages2.value);

      } else {
        adsImages2.clear();
      }
    } catch (e) {
      print("حدث خطأ: $e");
    } finally {
      getAdsIsLoading.value = false;
    }
  }


  Future<void> fetchArticles({bool isInitial = false}) async {
    if (isInitial) {
      currentPage = 1;
      articles.clear();
    }

    if (isFetchingMore.value) return;
    isFetchingMore.value = true;

    try {
      getArticlesIsLoading.value = true;
      articleResponse = await AdminProvider().getArticles(page: currentPage); // عدل الدالة لقبول صفحة

      if (articleResponse.data != null) {
        if (isInitial) {
          articles.value = articleResponse.data!.article!;
        } else {
          articles.addAll(articleResponse.data!.article!);
        }

        currentPage++;
        lastPage = articleResponse.data!.pagination!.lastPage!;
      } else {
        articles.clear();
      }

    } catch (e) {
      print("حدث خطأ: $e");
    } finally {

      isFetchingMore.value = false;
      getArticlesIsLoading.value = false;
    }
  }


  void initScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 &&
          currentPage <= lastPage) {
        fetchArticles(); // تحميل الصفحة التالية
      }
    });
  }
  Future<bool> manualCheck() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    isConnected.value = connectivityResult != ConnectivityResult.none;

    return isConnected.value;
  }
  Future<void> deleteAd({required int idAd}) async {

    await manualCheck();

    if (!isConnected.value) return;
    try {
      deleteAdIsLoading.value = true;
      genericResponse = await AdminProvider().deleteAd(
        idAd: idAd,
      );
      if(genericResponse.success == true){

        Get.snackbar('تم', genericResponse.message ?? 'تم حذف الموعد');
        fetchAds();

      }else{
        Get.snackbar('خطأ', genericResponse.message ?? 'فشل في حذف الموعد');
      }
    } catch (e) {

    } finally {
      deleteAdIsLoading.value = false;
    }
    // هنا يمكن تخزين الاسم في التخزين المحلي أو إرسال API
  }

  Future<void> deleteArticle({required int idArticle}) async {

    await manualCheck();

    if (!isConnected.value) return;
    try {
      deleteArticleIsLoading.value = true;
      genericResponse3 = await AdminProvider().deleteArticle(
        idArticle: idArticle,
      );
      if(genericResponse3.success == true){

        Get.snackbar('تم', genericResponse3.message ?? 'تم حذف الموعد');
        fetchArticles(isInitial: true);

      }else{
        Get.snackbar('خطأ', genericResponse3.message ?? 'فشل في حذف الموعد');
      }
    } catch (e) {

    } finally {
      deleteArticleIsLoading.value = false;
    }
    // هنا يمكن تخزين الاسم في التخزين المحلي أو إرسال API
  }



  Future<void> addPhoto() async {
    try {
      await manualCheck();

      if (!isConnected.value) {
        Get.bottomSheet(
          const NoInternetBottomSheet(),
          isDismissible: true,
          enableDrag: true,
        );
        return;
      }
      addPhotoIsLoading.value = true;
      genericResponse2 =
      await AdminProvider().addPhoto(imageFile: adsImages.first);
      if (genericResponse2.success == true) {
        Get.snackbar('تم', genericResponse2.message ?? 'تم رفع الصورة');

      } else {
        Get.snackbar('خطأ', genericResponse2.message ?? 'فشل في رفع الصورة');
      }
    } finally {
      addPhotoIsLoading.value = false;
    }
  }


  void clearArticle() {
    articleTitleAR.value = '';
    articleTitleEN.value = '';
    articleContentAR.value = '';
    articleContentEN.value = '';
  }

  Future<void> submitArticle() async {
    await manualCheck();

    if (!isConnected.value) {
      Get.bottomSheet(
        const NoInternetBottomSheet(),
        isDismissible: true,
        enableDrag: true,
      );
      return;
    }

    if (articleTitleAR.value.isNotEmpty &&
        articleTitleEN.value.isNotEmpty &&
        articleContentEN.value.isNotEmpty &&
        articleContentAR.value.isNotEmpty) {
      try {
        articleIsLoading.value = true;

        genericResponse = await AdminProvider().sendArticle(
            titleAr: articleTitleAR.value,
            titleEn: articleTitleEN.value,
            bodyAr: articleContentAR.value,
            bodyEn: articleContentEN.value);
        if (genericResponse.success == true) {

          Get.snackbar('تم', genericResponse.message ?? 'تم إضافة المقال');
          fetchArticles();
        } else {
          Get.snackbar('خطأ', genericResponse.message ?? 'فشل في إضافة المقال');
        }
      } catch (e) {
        print("خطأ أثناء إرسال المقال: $e");
        Get.snackbar('خطأ', 'حدث خطأ أثناء الإرسال');
      }
      finally {
        articleIsLoading.value = false;
      }
    } else {
      Get.snackbar('خطأ', 'يرجى ملء جميع الحقول');
    }
  }
  Future<void> logOut() async {
    await manualCheck();

    if (!isConnected.value) return;
    try {
      await UserProvider().logOutUser(isDoctor:false);
    } catch (e) {
      // الخطأ تم التعامل معه مسبقًا في DioHelper
    } finally {
      getStorage.deleteToken();
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAds();
    initScrollListener();
    fetchArticles(isInitial: true);

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
