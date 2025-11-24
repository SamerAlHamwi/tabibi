import 'package:flutter/material.dart';
import 'package:my_app/app/theme/app_colors.dart';

PreferredSizeWidget customAppBar({
  required String title,
  bool centerTitle = true,
  List<Widget>? actions,
  Widget? leading,
}) {
  return AppBar(

    surfaceTintColor: Colors.transparent,
    elevation: 0,
    backgroundColor: AppColors.scaffoldBackground,
    title: Text(title),
    centerTitle: centerTitle,
    leading: leading,
    actions: actions,

  );
}
