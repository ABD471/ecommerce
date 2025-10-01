import 'package:ecommerce_flutter/Const/routes.dart';
import 'package:ecommerce_flutter/Screens/Auth/login.dart';
import 'package:ecommerce_flutter/Screens/admin/dashboard/dashboard_vendor.dart/vendorscreen.dart';
import 'package:ecommerce_flutter/locale/translate.dart';
import 'package:ecommerce_flutter/theme/theme.dart';
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
        home: Material(child: VendorScreen()),
        translations: Translate(),
        theme: lightTheme,
        darkTheme: darkTheme,

        // theme: adminTheme,
        locale: Locale("ar"),
        themeMode: ThemeMode.light,
        getPages: routes,
      );
    });
  }
}

final ThemeData adminTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2C3E50)),
  primaryColor: const Color(0xFF2C3E50),
  scaffoldBackgroundColor: const Color(0xFFF4F6F8),
  cardColor: Colors.white,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 253, 253, 253)),
    bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF333333)),
    titleMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF2C3E50)),
    bodySmall: TextStyle(fontSize: 14, color: Color(0xFF666666)),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF2C3E50),
    contentTextStyle: TextStyle(color: Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Color(0xFF2C3E50)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Color(0xFF2C3E50), width: 2),
    ),
    labelStyle: TextStyle(color: Color(0xFF2C3E50)),
    prefixIconColor: Color(0xFF2C3E50),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF2C3E50),
    foregroundColor: Colors.white,
    elevation: 2,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
);
