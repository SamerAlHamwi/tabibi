import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/appbar_widget.dart';
import '../controllers/admin_controller.dart';
import 'admin_dispaly_view.dart';
import 'admin_view.dart';

class AdminTabbedPage extends StatelessWidget {
  final AdminController controller = Get.put(AdminController());

  AdminTabbedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customAppBar(
          title: "لوحة تحكم الأدمن",
          leading: IconButton(
            onPressed: controller.logOut,
            tooltip: 'تسجل الخروج',
            icon: const Icon(Icons.logout, color: Colors.red),
          ),
        ),
        body: Column(
          children: [
            const TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(text: "إضافة"),
                Tab(text: "العرض"),
              ],
            ),
            const Divider(height: 1),
            Expanded(
              child: TabBarView(
                children: [
                  AdminView(), // تبويب الإضافة
                  AdminDisplayView(), // تبويب العرض
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
