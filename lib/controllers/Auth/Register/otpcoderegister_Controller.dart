import 'package:ecommerce_flutter/Const/url_client.dart';
import 'package:ecommerce_flutter/Services/api_services.dart';
import 'package:ecommerce_flutter/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OtpcoderegisterController extends GetxController {
  RxBool isloading = false.obs;

  void onComplete(String pin) async {
    isloading.value = true;

    try {
      final Map<String, dynamic> userData = Get.arguments;
      print(userData);
      final user = userData['user'];

      final Map<String, dynamic> jsonData = {
        "email": user['email'],
        "hash_otp": pin,
      };

      final result = await ApiService.postRequest(
        url: urlClient["otpRegester"]!,
        data: jsonData,
      );

      final statusCode = result["statusCode"];
      final body = result["body"];

      switch (statusCode) {
        case 200:
          if (userData["message"] == 'Account created successfully') {
            Get.toNamed("/");
          } else {
            Get.toNamed("/newPasswordPage", arguments: user);
          }
          showDialogWithLottie(
            title: "otp_verified_title".tr,
            message: "otp_verified_message".tr,
            lottieAsset: "assets/lottie/Success.json",
          );
          break;

        case 600:
        case 601:
        case 602:
        case 603:
        case 604:
          showDialogWithLottie(
            title: "dialog_error_title".tr,
            message: body['message'] ?? "dialog_error_title".tr,
            lottieAsset: "assets/lottie/Error.json",
          );
          break;

        default:
          showDialogWithLottie(
            title: "dialog_unexpected_title".tr,
            message: "dialog_unexpected_code".trParams({"code": "$statusCode"}),
            lottieAsset: "assets/lottie/Alert.json",
          );
      }
    } catch (e) {
      showDialogWithLottie(
        title: "dialog_exception_title".tr,
        message: e.toString(),
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
}
