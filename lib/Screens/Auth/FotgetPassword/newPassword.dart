import 'package:ecommerce_flutter/controllers/Auth/ForgetPasswotd/newPassword_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../CustomScreen/coustom_NewPassword_Screen.dart'
    show layoutFelidPassword, layoutButtonLogin, layoutFelidRepassword;
import '../CustomScreen/coustom_SignUp_Screen.dart' show layoutClipPath;

class Newpasswordscreen extends StatelessWidget {
  const Newpasswordscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    NewpasswordController controller = Get.put(NewpasswordController());
    String data = "New Password";
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Obx(() {
          if (controller.isloading.value == true) {
            return Center(
              child: Lottie.asset('assets/lottie/Loading.json',
                  height: 30.h, width: 20.w),
            );
          } else {
            return ListView(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      layoutClipPath(data),
                      Container(
                        height: 10.h,
                      ),
                      Container(
                          child: ListTile(
                        title: Text("please Enter your New Password "),
                        titleTextStyle: TextStyle(
                            color: Color.fromARGB(255, 19, 36, 180),
                            fontSize: 18),
                      )),
                      Container(
                        height: 3.h,
                      ),
                      layoutFelidPassword(controller),
                      Container(
                        height: 3.h,
                      ),
                      layoutFelidRepassword(controller),
                      Container(
                        height: 3.h,
                      ),
                      InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              controller.onSave();
                            }
                          },
                          child: layoutButtonLogin()),
                    ],
                  ),
                )
              ],
            );
          }
        }));
  }
}
