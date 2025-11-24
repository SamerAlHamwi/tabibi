import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_app/app/modules/home/widgets/top_doctors_widget.dart';

import '../../../../generated/locales.g.dart';
import '../../../widgets/appbar_widget.dart';
import '../widgets/article_card_widget.dart';
import '../widgets/carousel_slider_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: customAppBar(
        title: '${LocaleKeys.welcome.tr} ${controller.getStorage.getUserData()!.name!}',
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => RefreshIndicator(
          onRefresh: () async {
           await controller.fetchAds();
           await controller.fetchArticles(isInitial: true);
          },
          child: Obx(() => ListView(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(), // 👈 مهم
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            children: [


              Obx(() {
                if (controller.imageList.isEmpty) {
                  return Center(child: Text(LocaleKeys.no_ads_currently.tr));
                } else {
                  return ImageCarouselWidget(imageList: controller.imageList);
                }
              }),

              const SizedBox(height: 20),

              controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox(),

              const SizedBox(height: 20),

         Text(LocaleKeys.articles.tr, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 10),

              Obx(() => Column(
                children: controller.articles.map((article) {
                  return ArticleCard(article: article,lang: controller.getStorage.getLanguage() == 'ar',);
                }).toList(),
              )),

              if (controller.isFetchingMore.value) // 👈 مؤشر تحميل أسفل القائمة
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                )
            ],
          )),
        ),
      ),
    );
  }

}
