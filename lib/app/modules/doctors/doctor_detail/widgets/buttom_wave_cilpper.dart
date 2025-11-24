import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double step = size.width * 0.028; // تقليل الموجة بزيادة نسبة الخطوة (0.05 بدلًا من 0.03)
    final double baseY = 20.0; // الأساس
    final int pointsCount = (size.width / step).ceil();

    final random = Random();

    path.moveTo(0, size.height);
    path.lineTo(0, baseY);

    for (int i = 1; i <= pointsCount; i++) {
      // زيادة التفاوت بين القمة والقاع
      double variation = (i % 2 == 0 ? -1 : 2) * (random.nextDouble() * 40 + 20); // بين 20 و 60 (زيادة الارتفاع)
      double x = i * step;
      double y = baseY + variation;

      // حد علشان ما يطلع عن الشاشة
      y = y.clamp(0.0, size.height * 0.9);

      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
