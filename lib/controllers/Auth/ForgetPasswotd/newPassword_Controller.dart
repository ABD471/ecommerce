import 'package:ecommerce_flutter/Const/url_client.dart';
import 'package:ecommerce_flutter/Services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NewpasswordController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController repassword;
  late GlobalKey<FormState> formKey;
  RxBool hiden = true.obs;
  RxBool isloading = false.obs;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    repassword = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.onInit();
  }

  void onSave() async {
    if (password.text != repassword.text) {
      showDialogWithLottie(
        title: "dialog_error_title".tr,
        message: "password_mismatch".tr,
        lottieAsset: "assets/lottie/Error.json",
      );
      return;
    }

    isloading.value = true;

    final user = Get.arguments;
    final jsonData = {
      "email": user['email'],
      "password": password.text,
    };

    try {
      final result = await ApiService.postRequest(
        url: urlClient["resetpassword"]!,
        data: jsonData,
      );

      final statusCode = result["statusCode"];

      if (statusCode == 200) {
        Get.offAllNamed("/");
        showDialogWithLottie(
          title: "newpass_change_title".tr,
          message: "newpass_change_message".tr,
          lottieAsset: "assets/lottie/Success.json",
        );
      } else {
        showDialogWithLottie(
          title: "dialog_unexpected_title".tr,
          message:
              "newpass_unexpected_message".trParams({"code": "$statusCode"}),
          lottieAsset: "assets/lottie/Alert.json",
        );
      }
    } catch (e) {
      showDialogWithLottie(
        title: "dialog_exception_title".tr,
        message: "dialog_exception_message".trParams({"error": e.toString()}),
        lottieAsset: "assets/lottie/Error.json",
      );
    } finally {
      isloading.value = false;
    }
  }

  void onTapHiden() => hiden.value = !hiden.value;

  void showDialogWithLottie({
    required String title,
    required String message,
    required String lottieAsset,
  }) {
    Get.defaultDialog(
      title: title,
      content: Column(
        children: [
          SizedBox(height: 150, child: Lottie.asset(lottieAsset)),
          const SizedBox(height: 10),
          Text(message, textAlign: TextAlign.center),
        ],
      ),
      textConfirm: "dialog_confirm".tr,
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }
}
