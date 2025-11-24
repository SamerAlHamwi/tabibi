import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app/widgets/appbar_widget.dart';
import 'package:my_app/generated/locales.g.dart';

import '../controllers/settings_controller.dart';

class AboutAppView extends GetView<SettingsController> {
  const AboutAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'حول التطبيق', // استخدم .tr إذا تستخدم localization
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'طبيبي',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      LocaleKeys.about_app.tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'إصدار التطبيق: 1.0.0',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
