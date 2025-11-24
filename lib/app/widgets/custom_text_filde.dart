import 'package:flutter/material.dart';
import 'package:my_app/app/core/constants/constants.dart';
import '../theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? errorText;
  final String? hintText;
  final int? maxLength;
  final double width ;
  final double height;
  final double radius;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;

   CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.maxLength,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.width = 0.90,
    this.height =  0.075,
    this.radius = 10,
     this.errorText,
     this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Center(
      child: SizedBox(
        width: SizeConfig.screenWidth * width,
        height: SizeConfig.screenHeight * height,
        child:  TextFormField(

        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
        maxLength: maxLength, // ← هذا هو التصحيح
        decoration: InputDecoration(
          hintText: hintText,
          isDense: true,
          errorText: errorText,
          errorStyle: const TextStyle(height: .1),
          filled: true,
          fillColor: AppColors.white,
          labelText: label,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? GestureDetector(
            onTap: onSuffixTap,
            child: Icon(suffixIcon),
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: errorText != null ? Colors.red : Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: errorText != null ? Colors.red : AppColors.primary,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

    ),
    );
  }
}
