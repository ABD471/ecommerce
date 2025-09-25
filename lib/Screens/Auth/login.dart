import 'package:ecommerce_flutter/Screens/Auth/CustomScreen/coustom_Login_Screen.dart';
import 'package:ecommerce_flutter/Screens/Auth/CustomScreen/coustom_SignUp_Screen.dart'
    hide layoutFelidEmail;
import 'package:ecommerce_flutter/controllers/Auth/login_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class Login_In extends StatelessWidget {
  const Login_In({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    LoginController controller = Get.put(LoginController());
    String data = "1".tr;
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
                    layoutFelidEmail(controller),
                    Container(
                      height: 3.h,
                    ),
                    layoutFelidPassword(controller),
                    Container(
                      padding: EdgeInsets.only(top: 2.h, left: 60.w),
                      child: InkWell(
                        onTap: () {
                          controller.onForgetPassword();
                        },
                        child: Text("6".tr),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            controller.onLogin();
                          }
                        },
                        child: layoutButtonLogin()),
                    Container(
                      height: 5.h,
                      margin: EdgeInsets.only(
                        left: 25.w,
                        right: 25.w,
                        top: 2.h,
                      ),
                      child: layoutHaveAccount(controller),
                    )
                  ],
                ),
              )
            ],
          );
        }
      }),
    );
  }
}
