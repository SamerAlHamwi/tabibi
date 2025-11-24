import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/locales.g.dart';

class NoInternetBottomSheet extends StatelessWidget {
  const NoInternetBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child:  Row(
        children: [
          const Icon(Icons.signal_wifi_off, color: Colors.red, size: 28),
          const SizedBox(width: 12),
          Text(LocaleKeys.no_internet.tr, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
