import 'package:ecommerce_flutter/Screens/Auth/CustomScreen/coustom_SignUp_Screen.dart';
import 'package:ecommerce_flutter/controllers/Auth/Register/otpcoderegister_Controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class Otpcoderegisterscreen extends StatelessWidget {
  const Otpcoderegisterscreen({super.key});

  @override
  Widget build(BuildContext context) {
    OtpcoderegisterController controller = Get.put(OtpcoderegisterController());
    String data = "OTP CODE";
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    layoutClipPath(data),
                    Container(
                      height: 3.h,
                    ),
                    Container(
                        child: ListTile(
                      subtitle: Text(
                          "We Will,Send verifictoin Code To  your Regiester Email ID"),
                    )),
                    SizedBox(
                      width: 70.w,
                      height: 17.h,
                      child: OTPTextField(
                        length: 5,
                        width: 100.w,
                        fieldStyle: FieldStyle.box,
                        spaceBetween: 0,
                        onCompleted: (pin) {
                          controller.onComplete(pin);
                        },
                      ),
                    ),
                  ],
                )
              ],
            );
          }
        }));
  }
}
