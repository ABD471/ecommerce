import 'package:ecommerce_flutter/Const/url_client.dart';
import 'package:ecommerce_flutter/Services/api_services.dart';
import 'package:ecommerce_flutter/models/email_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ForgetpasswordController extends GetxController {
  late TextEditingController email;
  late GlobalKey<FormState> formKey;
  RxBool isloading = false.obs;

  @override
  void onInit() {
    email = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.onInit();
  }

  void onNext() async {
    if (!formKey.currentState!.validate()) return;

    isloading.value = true;

    final emailModel = EmailModel(email: email.text);

    try {
      final result = await ApiService.postRequest(
        url: urlClient["forgetpassword"]!,
        data: emailModel.toJson(),
      );

      final statusCode = result["statusCode"];
      final body = result["body"];

      if (statusCode == 200) {
        Get.toNamed("/otpCodeRegisterPage", arguments: body);
        showDialogWithLottie(
          title: "forget_sent_title".tr,
          message: "forget_sent_message".tr,
          lottieAsset: "assets/lottie/Success.json",
        );
      } else if (statusCode == 404) {
        showDialogWithLottie(
          title: "forget_not_found_title".tr,
          message: body["message"] ??
              "forget_error_message".trParams({"message": ""}),
          lottieAsset: "assets/lottie/Error.json",
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
