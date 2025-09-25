import 'package:ecommerce_flutter/Screens/Auth/CustomScreen/coustom_ForgetPassword_Screen.dart';
import 'package:ecommerce_flutter/Screens/Auth/CustomScreen/coustom_SignUp_Screen.dart'
    hide layoutFelidEmail;
import 'package:ecommerce_flutter/controllers/Auth/ForgetPasswotd/forgetPassword_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class ForgetPassword_Screen extends StatelessWidget {
  const ForgetPassword_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetpasswordController controller = Get.put(ForgetpasswordController());
    String data = "Forget Password";
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Obx(
        () {
          if (controller.isloading.value == true) {
            return Center(
              child: Lottie.asset('assets/lottie/Loading.json',
                  height: 30.h, width: 20.w),
            );
          } else {
            return ListView(
              children: [
                Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      layoutClipPath(data),
                      Container(
                        height: 20.h,
                      ),
                      Container(
                          child: ListTile(
                        title: Text("please Enter your Regiester Email ID"),
                        titleTextStyle: TextStyle(
                            color: Color.fromARGB(255, 19, 36, 180),
                            fontSize: 18),
                        subtitle: Text(
                            "We Will,Send verifictoin Code To  your Regiester Email ID"),
                      )),
                      Container(
                        height: 1.h,
                      ),
                      layoutFelidEmail(controller),
                      Container(
                        height: 3.h,
                      ),
                      MaterialButton(
                        elevation: 10,
                        height: 40,
                        minWidth: 200,
                        color: Color.fromARGB(255, 19, 36, 180),
                        onPressed: () {
                          controller.onNext();
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
