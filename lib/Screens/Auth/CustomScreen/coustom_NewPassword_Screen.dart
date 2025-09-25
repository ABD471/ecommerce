import 'package:ecommerce_flutter/controllers/Auth/ForgetPasswotd/newPassword_Controller.dart';
import 'package:ecommerce_flutter/fucachion/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../Const/CostumFieldTExt.dart';

Widget layoutFelidPassword(NewpasswordController controller) {
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
      "Save".tr,
      style: TextStyle(color: Colors.white),
    ),
  );
}

Widget layoutFelidRepassword(NewpasswordController controller) {
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
