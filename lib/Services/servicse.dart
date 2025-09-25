import 'package:ecommerce_flutter/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Service extends GetxService {
  late Locale initLocale = sharedPreferences.getString("Langauge") == "ar"
      ? Locale("ar")
      : Locale("en");

  @override
  void onInit() {
    Get.updateLocale(initLocale);
    super.onInit();
  }
}
