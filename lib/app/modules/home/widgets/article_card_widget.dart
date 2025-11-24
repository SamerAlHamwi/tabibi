import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../data/models/user_models/artical_response.dart';

class ArticleCard extends StatefulWidget {
  final Article article;
  final bool lang;

  const ArticleCard({Key? key, required this.article,required this.lang}) : super(key: key);

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool isExpanded = false;

  static const int maxLength = 100; // عدد الأحرف قبل الاختصار

  @override
  Widget build(BuildContext context) {
    final body = widget.lang ? widget.article.bodyAr ?? LocaleKeys.no_content.tr : widget.article.bodyEn ?? LocaleKeys.no_content.tr ;
    final isLong = body.length > maxLength;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(widget.lang ? widget.article.titleAr ?? LocaleKeys.no_content.tr  : widget.article.titleEn ?? LocaleKeys.no_content.tr ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isExpanded || !isLong ? body : '${body.substring(0, maxLength)}...',
            ),
            if (isLong)
              TextButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(isExpanded ? LocaleKeys.read_less.tr  : LocaleKeys.read_more.tr ),
              ),
          ],
        ),

      ),
    );
  }
}
