import 'package:ecommerce_flutter/Const/CostumFieldTExt.dart';
import 'package:ecommerce_flutter/Const/RpsPainter.dart';
import 'package:ecommerce_flutter/controllers/Auth/Register/signUp_Controller.dart';
import 'package:ecommerce_flutter/fucachion/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget layoutClipPath(String data) {
  return Container(
    padding: EdgeInsets.all(0),
    width: 100.w,
    height: 30.h,
    //color: Colors.amberAccent,
    child: CustomPaint(
      painter: RPSCustomPainter(),
      size: Size.square(5),
      child: Container(
        padding: EdgeInsets.only(top: 9.h),
        child: Text(
          data.tr,
          style: TextStyle(fontSize: 35, color: Colors.white),
          textDirection: TextDirection.ltr,
        ),
      ),
    ),
  );
}

Widget layoutFelidUserName(SignupController controller) {
  return Container(
    padding: EdgeInsets.only(left: 0.5.h, right: 0.5.h),
    child: Costumfiledtext(
        obscureText: false,
        hintText: "10".tr,
        Mycontroller: controller.username,
        validator: (val) {
          return myValidator(val, 16, 55, "username");
        },
        label: "11".tr,
        IconData: Icon(
          Icons.person_2_rounded,
          color: const Color.fromARGB(255, 19, 36, 180),
        )),
  );
}

Widget layoutFelidPhone(SignupController controller) {
  return Container(
    padding: EdgeInsets.only(left: 0.5.h, right: 0.5.h),
    child: Costumfiledtext(
        obscureText: false,
        hintText: "12".tr,
        Mycontroller: controller.phone,
        validator: (val) {
          return myValidator(val, 16, 55, "phone");
        },
        label: "13".tr,
        IconData: Icon(
          Icons.numbers,
          color: const Color.fromARGB(255, 19, 36, 180),
        )),
  );
}

Widget layoutFelidEmail(SignupController controller) {
  return Container(
      padding: EdgeInsets.only(left: 0.5.h, right: 0.5.h),
      child: Costumfiledtext(
        obscureText: false,
        Mycontroller: controller.email,
        hintText: "2".tr,
        label: "3".tr,
        IconData: Icon(
          Icons.email_rounded,
          color: const Color.fromARGB(255, 19, 36, 180),
        ),
        validator: (val) {
          return myValidator(val, 8, 25, "email");
        },
      ));
}

Widget layoutFelidPssword(SignupController controller) {
  return Container(
      padding: EdgeInsets.only(left: 0.5.h, right: 0.5.h),
      child: Costumfiledtext(
        obscureText: true,
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

Widget layoutFelidRepassword(SignupController controller) {
  return Container(
      padding: EdgeInsets.only(left: 0.5.h, right: 0.5.h),
      child: Costumfiledtext(
        obscureText: true,
        Mycontroller: controller.repassword,
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

Widget layoutButtonSignUp() {
  return Container(
    height: 4.h,
    alignment: AlignmentGeometry.center,
    //color: Colors.amber,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(1),
      color: Color.fromARGB(255, 19, 36, 180),
    ),

    margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 3.h),
    child: Text(
      "9".tr,
      style: TextStyle(color: Colors.white),
    ),
  );
}
