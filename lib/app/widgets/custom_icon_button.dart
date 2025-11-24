import 'package:flutter/material.dart';
import 'package:my_app/app/theme/app_colors.dart';
import '../core/constants/constants.dart';

class CustomIconButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color iconColor;
  final Color backgroundColor;
  final double diameter;

  const CustomIconButtonWidget({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.size = 24.0,
    this.iconColor = AppColors.black,
    this.backgroundColor = AppColors.white,
    this.diameter = 50.0, // القطر الكامل للزر الدائري
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(diameter / 2),
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: size,
          color: iconColor,
        ),
      ),
    );
  }
}
