import 'package:ecommerce_flutter/Const/routes.dart';
import 'package:ecommerce_flutter/Screens/Auth/login.dart';
import 'package:ecommerce_flutter/locale/translate.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Serverpod Demo',
        home: Login_In(),
        translations: Translate(),
        locale: Locale("ar"),
        themeMode: ThemeMode.system,
        getPages: routes,
      );
    });
  }
}
