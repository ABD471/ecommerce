import 'package:ecommerce_flutter/Const/CostumFieldTExt.dart';
import 'package:ecommerce_flutter/controllers/Auth/ForgetPasswotd/forgetPassword_Controller.dart';
import 'package:ecommerce_flutter/fucachion/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget layoutFelidEmail(ForgetpasswordController controller) {
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
