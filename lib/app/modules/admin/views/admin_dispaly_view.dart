import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/generated/locales.g.dart';
import '../../../data/http/app_links.dart';
import '../../../widgets/appbar_widget.dart';
import '../../../widgets/confirm_delete_dialog.dart';
import '../controllers/admin_controller.dart';

class AdminDisplayView extends StatelessWidget {
  final AdminController controller = Get.find<AdminController>();

  AdminDisplayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "عرض الإعلانات والمقالات"),
      body: Obx(
        () => ListView(
          controller: controller.scrollController,
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                const Text("الإعلانات:", style: TextStyle(fontSize: 18)),
                const Spacer(),
                IconButton(onPressed: ()  { controller.fetchAds();
                 controller.fetchArticles(isInitial: true);}, icon: const Icon(Icons.refresh))
              ],
            ),
            const SizedBox(height: 10),
            controller.getAdsIsLoading.value
                ? const Center(child: CircularProgressIndicator())
                :controller.adsImages2.isEmpty? const Center(child: Text('لا توجد صور مضافة بعد'),): SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.adsImages2.length,
                      itemBuilder: (context, index) {
                        final imgUrl = controller.adsImages2[index];
                        return Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: imgUrl,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  // ✅ حجم ثابت
                                  height: 100,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2)),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.broken_image,
                                          size: 100),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: ()
                        =>
                                    showConfirmDeleteDialog(
                                    title: LocaleKeys.warning.tr,
                                    message: LocaleKeys
                                        .do_you_sure_for_this_action.tr,
                                    onConfirm: () {
                                      controller.deleteAd(
                                          idAd: controller
                                              .adsResponse.data![index].id!);
                                    }),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.delete,
                                      size: 26, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
            const Divider(height: 40),
            const Text("المقالات:", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Obx(
              () => Column(
                children: controller.articles.asMap().entries.map((entry) {
                  int index = entry.key;
                  var article = entry.value;
                  return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(article.titleAr ?? 'بدون عنوان'),
                        subtitle: Text(article.bodyAr ?? 'بدون محتوى'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => showConfirmDeleteDialog(
                              title: LocaleKeys.warning.tr,
                              message:
                                  LocaleKeys.do_you_sure_for_this_action.tr,
                              onConfirm: () {
                                controller.deleteArticle(
                                    idArticle:
                                        controller.articles[index].id!);
                              }),
                        ),
                      ));
                }).toList(),
              ),
            ),
            if (controller.isFetchingMore.value) // 👈 مؤشر تحميل أسفل القائمة
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              )
          ],
        ),
      ),
    );
  }
}
