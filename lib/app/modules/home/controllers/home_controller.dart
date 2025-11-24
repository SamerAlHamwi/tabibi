import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/services/api_service.dart';
import '../../../core/storage/storage_service.dart';
import '../../../data/http/app_links.dart';
import '../../../data/models/user_models/ads_response.dart';
import '../../../data/models/user_models/artical_response.dart';
import '../../../data/providers/admin_provider.dart';
import '../../../widgets/no_internet_buttom_sheet.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final RxList<String> imageList = <String>[].obs;

  // var doctors = <Doctors>[].obs;
  var isLoading = false.obs;
  var getAdsIsLoading = false.obs;
  var getArticlesIsLoading = false.obs;

  final count = 0.obs;
  StorageService getStorage = StorageService();
  RxBool isConnected = true.obs;
  AdsResponse adsResponse = AdsResponse();
  ArticleResponse articleResponse = ArticleResponse();

  RxList<Article> articles = <Article>[].obs;
  ScrollController scrollController = ScrollController();

  int currentPage = 1;
  int lastPage = 1;
  RxBool isFetchingMore = false.obs;

  Future<bool> manualCheck() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    isConnected.value = connectivityResult != ConnectivityResult.none;

    return isConnected.value;
  }


  Future<void> fetchArticles({bool isInitial = false}) async {
    await manualCheck();

    if (!isConnected.value) {
      Get.bottomSheet(
        const NoInternetBottomSheet(),
        isDismissible: true,
        enableDrag: true,
      );
      return;
    }
    if (isInitial) {
      currentPage = 1;
      articles.clear();
    }

    if (isFetchingMore.value) return;
    isFetchingMore.value = true;

    try {
      getArticlesIsLoading.value = true;
      articleResponse = await AdminProvider().getArticles(
          page: currentPage); // عدل الدالة لقبول صفحة

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
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200 &&
          currentPage <= lastPage) {
        fetchArticles(); // تحميل الصفحة التالية
      }
    });
  }

  Future<void> fetchAds() async {
    await manualCheck();

    if (!isConnected.value) return;

    try {
      getAdsIsLoading.value = true;
      adsResponse = await AdminProvider().getAds();

      if (adsResponse.data != null) {
        // استخراج الصور وتحويلها إلى روابط كاملة
        imageList.value = adsResponse.data!
            .map((e) => "https://api.doctorme.site/storage/${e.photo}")
            .toList();
        getStorage.saveAds(imageList.value);
      } else {
        imageList.clear();
      }
    } catch (e) {
      print("حدث خطأ: $e");
    } finally {
      getAdsIsLoading.value = false;
    }
  }

  // Future<void> fetchTopDoctors() async {
  //   try {
  //     isLoading.value = true;
  //     await DioHelper.getData(
  //       url: AppLink.getDoctors,
  //       onRetry: fetchTopDoctors,
  //     ).then((response) {
  //       final result = DoctorsModelResponse.fromJson(response.data);
  //       doctors.value = result.doctors!;
  //     });
  //   } catch (e) {
  //     // الخطأ تم التعامل معه مسبقًا في DioHelper
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  @override
  void onInit() {
    fetchAds();
    initScrollListener();
    fetchArticles(isInitial: true);

    final savedAds = getStorage.getAds();
    if (savedAds != null) {
      imageList.value = savedAds.map((e) => e.toString()).toList();
    }

    super.onInit();
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
