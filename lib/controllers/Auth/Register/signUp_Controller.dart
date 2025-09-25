import 'package:ecommerce_flutter/Const/url_client.dart';
import 'package:ecommerce_flutter/Services/api_services.dart';
import 'package:ecommerce_flutter/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignupController extends GetxController {
  RxBool isloading = false.obs;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController repassword;
  late TextEditingController phone;
  late TextEditingController username;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    repassword = TextEditingController();
    phone = TextEditingController();
    username = TextEditingController();
    super.onInit();
  }

  void onSignUp() async {
    if (password.text != repassword.text) {
      showDialogWithLottie(
        title: "dialog_error_title".tr,
        message: "signup_password_mismatch".tr,
        lottieAsset: "assets/lottie/Error.json",
      );
      return;
    }

    final user = UserModel(
      email: email.text,
      username: username.text,
      password: password.text,
    );

    isloading.value = true;

    try {
      final result = await ApiService.postRequest(
        url: urlClient["signup"]!,
        data: user.toJson(),
      );

      final statusCode = result["statusCode"];
      final body = result["body"];

      if (statusCode == 200) {
        Get.toNamed("/otpCodeRegisterPage", arguments: body);
        showDialogWithLottie(
          title: "dialog_success_title".tr,
          message: "signup_created_success".tr,
          lottieAsset: "assets/lottie/Success.json",
        );
      } else if (statusCode == 409) {
        showDialogWithLottie(
          title: "dialog_unexpected_title".tr,
          message: body["error"] ?? "signup_exists".tr,
          lottieAsset: "assets/lottie/Alert.json",
        );
      } else {
        showDialogWithLottie(
          title: "dialog_unexpected_title".tr,
          message: "dialog_unexpected_code".trParams({"code": "$statusCode"}),
          lottieAsset: "assets/lottie/Error.json",
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

  void onLogin() {
    Get.offNamed("loginPage");
  }
}
