import 'dart:convert';

import 'package:ecommerce_flutter/models/dashboard_users_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserDetailsController extends GetxController {
  Future<void> updateUser(User user, String oldEmail) async {
    final url = Uri.parse(
        'http://192.168.1.102:12321/dashboard_admin/put_edit_user.php'); // غيّر الرابط حسب عنوان السيرفر
    final payload = {
      "old_email": oldEmail,
      "new_email": user.email,
      "new_username": user.name,
      "new_role": user.role,
      "new_status": user.status
    };
    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NTkxOTkxNDksImV4cCI6MTc1OTIwMjc0OSwiZGF0YSI6eyJ1c2VyX2lkIjo2NywiZW1haWwiOiJkYmFhbG1qZWQyMDA0QGdtYWlsLmNvbSIsInJvbGUiOiJhZG1pbiJ9fQ.gUjfbvxebhfwp3jB9uk0qXshvwHYcPpfpPil12fg-A4',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        Get.back(); // للعودة إلى الصفحة السابقة
      } else {
        print('فشل التعديل: ${response.statusCode}');
      }
    } catch (e) {
      print('حدث خطأ أثناء الاتصال: $e');
    }
  }
}
