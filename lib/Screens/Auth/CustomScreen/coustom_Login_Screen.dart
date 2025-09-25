import 'package:ecommerce_flutter/Const/CostumFieldTExt.dart';
import 'package:ecommerce_flutter/controllers/Auth/login_Controller.dart';
import 'package:ecommerce_flutter/fucachion/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget layoutFelidEmail(LoginController controller) {
  return Container(
    padding: EdgeInsets.only(left: 0.5.h, right: 0.5.h),
    child: Costumfiledtext(
        obscureText: false,
        hintText: "2".tr,
        Mycontroller: controller.email,
        validator: (val) {
          return myValidator(val, 16, 55, "email");
        },
        label: "3".tr,
        IconData: Icon(
          Icons.email_rounded,
          color: const Color.fromARGB(255, 19, 36, 180),
        )),
  );
}

Widget layoutFelidPassword(LoginController controller) {
  return Container(
      padding: EdgeInsets.only(left: 0.5.h, right: 0.5.h),
      child: Costumfiledtext(
        hide: InkWell(
          onTap: () => controller.onTapHiden(),
          child: Icon(Icons.remove_red_eye),
        ),
        obscureText: controller.hiden.value,
        Mycontroller: controller.password,
        hintText: "4".tr,
        label: "5".tr,
        IconData: Icon(
          Icons.password_sharp,
          color: const Color.fromARGB(255, 19, 36, 180),
        ),
        validator: (val) {
          return myValidator(val, 8, 25, "password");
        },
      ));
}

Widget layoutButtonLogin() {
  return Container(
    height: 5.h,
    alignment: AlignmentGeometry.center,
    //color: Colors.amber,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(1),
      color: Color.fromARGB(255, 19, 36, 180),
    ),

    margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 3.h),
    child: Text(
      "7".tr,
      style: TextStyle(color: Colors.white),
    ),
  );
}

Widget layoutHaveAccount(LoginController controller) {
  return Row(
    children: [
      Container(
        child: Text("8".tr),
      ),
      InkWell(
        onTap: () => controller.onSignUp(),
        child: Container(
          child: Text(
            "9".tr,
            style: TextStyle(fontSize: 18),
          ),
        ),
      )
    ],
  );
}
