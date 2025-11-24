import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../widgets/appbar_widget.dart';
import '../controllers/signup_controller.dart';

class VerificationView extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());
  final phone = Get.arguments as String?; // قد تكون null
  final isDoctor = Get.parameters['isDoctor'] ==
      'true'; // إذا لم تُرسل، سترجع null وتكون false
  final mode = Get.parameters['mode'] ?? 'signup'; // الوضع الافتراضي هو التسجيل

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: LocaleKeys.verification_code.tr),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Text(LocaleKeys.enter_code.tr),
                  const SizedBox(height: 24),

                  // ✅ Stack لعرض الخانات وتغطيتها بحقل شفاف فعلي
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // 🟢 الخانات الظاهرة (عرض فقط)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (index) {
                          final text = controller.code.value;
                          return Container(
                            width: 45,
                            height: 55,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              index < text.length ? text[index] : '',
                              style: const TextStyle(fontSize: 24),
                            ),
                          );
                        }),
                      ),

                      // 🔵 حقل شفاف يغطي الخانات بالكامل ويُظهر قائمة اللصق
                      SizedBox(
                        width: 6 * 45 + 10 * 5, // ← نفس عرض الخانات مع الفراغات
                        height: 55,
                        child: TextField(
                          controller: controller.hiddenController,
                          focusNode: controller.hiddenFocusNode,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          onChanged: controller.onTextChanged,
                          showCursor: false,
                          cursorColor: Colors.teal,
                          style: const TextStyle(
                            color: Colors.transparent,
                            letterSpacing: 32, // لإبعاد الأحرف كما الخانات
                          ),
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                    ElevatedButton(
                    onPressed: (controller.sendForgetPasswordOtpIsLoading.value || controller.sendVerificationCodeIsLoading.value) ?null: () {
                      print(controller.code.value);
                      if (mode == 'forgetPassword') {
                        controller.sendForgetPasswordOtp(
                          phone: phone!,
                          isDoctor: isDoctor,
                        );
                      } else {
                        controller.sendOtp(phone: phone!,isDoctor: isDoctor);
                      }
                    },
                    child:  (controller.sendForgetPasswordOtpIsLoading.value || controller.sendVerificationCodeIsLoading.value) ?const SizedBox(
                        width:15 ,
                        height: 15,
                        child: Center(child: CircularProgressIndicator(),)) : Text(LocaleKeys.verify.tr),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
