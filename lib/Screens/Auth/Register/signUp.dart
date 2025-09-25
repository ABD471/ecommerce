import 'package:ecommerce_flutter/Screens/Auth/CustomScreen/coustom_SignUp_Screen.dart';
import 'package:ecommerce_flutter/controllers/Auth/Register/signUp_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class SignUp_Screen extends StatelessWidget {
  const SignUp_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKeyy = GlobalKey<FormState>();
    SignupController controller = Get.put(SignupController());
    String data = "1".tr;
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
              return ListView(children: [
                Form(
                  key: formKeyy,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      layoutClipPath(data),
                      Container(
                        height: 1.h,
                      ),
                      layoutFelidUserName(controller),
                      Container(
                        height: 2.h,
                      ),
                      layoutFelidPhone(controller),
                      Container(
                        height: 2.h,
                      ),
                      layoutFelidEmail(controller),
                      Container(
                        height: 2.h,
                      ),
                      layoutFelidPssword(controller),
                      Container(
                        height: 2.h,
                      ),
                      layoutFelidRepassword(controller),
                      InkWell(
                          onTap: () {
                            if (formKeyy.currentState!.validate()) {
                              controller.onSignUp();
                            }
                          },
                          child: layoutButtonSignUp()),
                      Container(
                        height: 5.h,
                        margin: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                          top: 2.h,
                        ),
                        child: Row(
                          children: [
                            Container(
                              child: Text("14".tr),
                            ),
                            InkWell(
                              onTap: () => controller.onLogin(),
                              child: Container(
                                child: Text(
                                  "7".tr,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]);
            }
          },
        ));
  }
}
