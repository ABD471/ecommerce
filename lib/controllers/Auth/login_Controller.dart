import 'package:ecommerce_flutter/Const/url_client.dart';
import 'package:ecommerce_flutter/Services/api_services.dart';
import 'package:ecommerce_flutter/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  RxBool hiden = true.obs;
  RxBool isloading = false.obs;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  void onLogin() async {
    isloading.value = true;

    try {
      final Map<String, dynamic> jsonData = {
        "email": email.text,
        "password": password.text,
      };

      final result = await ApiService.postRequest(
        url: urlClient["login"]!,
        data: jsonData,
      );

      final statusCode = result["statusCode"];
      final body = result["body"];

      if (statusCode == 200) {
        final user = UserModel.fromJson(body["user"]);
        Get.offAllNamed("signUpPage", arguments: user.toJson());

        showDialogWithLottie(
          title: "dialog_success_title".tr,
          message: "dialog_success_message".tr,
          lottieAsset: "assets/lottie/success.json",
        );
      } else if (statusCode == 401) {
        showDialogWithLottie(
          title: "dialog_error_title".tr,
          message: body["error"],
          lottieAsset: "assets/lottie/error.json",
        );
      } else {
        showDialogWithLottie(
          title: "dialog_unexpected_title".tr,
          message: "${"dialog_unexpected_code".tr} $statusCode",
          lottieAsset: "assets/lottie/warning.json",
        );
      }
    } catch (e) {
      showDialogWithLottie(
        title: "dialog_exception_title".tr,
        message: "${"dialog_exception_message".tr} $e",
        lottieAsset: "assets/lottie/error.json",
      );
    } finally {
      isloading.value = false;
    }
  }

  void showDialogWithLottie({
    required String title,
    required String message,
    required String lottieAsset,
  }) {
    Get.defaultDialog(
      title: title,
      content: Column(
        children: [
          SizedBox(
            height: 150,
            child: Lottie.asset(lottieAsset),
          ),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      textConfirm: "dialog_confirm".tr,
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }

  void onForgetPassword() {
    Get.toNamed("/forgetPasswordPage");
  }

  void onSignUp() {
    Get.toNamed("signUpPage");
  }

  void onTapHiden() {
    hiden.value = !hiden.value;
  }
}
