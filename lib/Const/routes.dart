import 'package:ecommerce_flutter/Screens/Auth/FotgetPassword/forgetPassword.dart';
import 'package:ecommerce_flutter/Screens/Auth/Register/otpCodeRegister.dart';
import 'package:ecommerce_flutter/Screens/Auth/login.dart';
import 'package:ecommerce_flutter/Screens/Auth/FotgetPassword/newPassword.dart';
import 'package:ecommerce_flutter/Screens/Auth/Register/signUp.dart';
import 'package:ecommerce_flutter/Screens/admin/dashboard/dashboard_users/users_screen.dart';

import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: "/loginPage",
    page: () => Login_In(),
  ),
  GetPage(
    name: "/signUpPage",
    page: () => SignUp_Screen(),
  ),
  GetPage(name: "/forgetPasswordPage", page: () => ForgetPassword_Screen()),
  GetPage(name: "/newPasswordPage", page: () => Newpasswordscreen()),
  GetPage(name: "/otpCodeRegisterPage", page: () => Otpcoderegisterscreen()),
  GetPage(name: "/dashboardUsers", page: () => UsersScreen()),
];
