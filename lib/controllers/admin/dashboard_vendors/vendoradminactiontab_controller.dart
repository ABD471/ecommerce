import 'dart:convert';

import 'package:ecommerce_flutter/models/dashboard_vendors_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VendoradminactiontabController extends GetxController {
  final Vendor vendor;
  late TextEditingController nameController;
  late TextEditingController descController;
  late TextEditingController logoController;
  VendoradminactiontabController({required this.vendor});

  @override
  void onInit() {
    nameController = TextEditingController(text: vendor.storeName);
    descController = TextEditingController(text: vendor.storeDescription);
    logoController = TextEditingController(text: vendor.storeLogo);
    super.onInit();
  }

  // التوكن الموحد
  static const String authToken =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NTkzMTUwMTYsImV4cCI6MTc1OTMxODYxNiwiZGF0YSI6eyJ1c2VyX2lkIjo2OCwiZW1haWwiOiJhYmRhbG1qZWQyMjJAZ21haWwuY29tIiwicm9sZSI6ImFkbWluIn19.1wwP6n5duLF1KZFSEUHmWjCypRCebBn6Gm7zBP3eyvE';
  void onActiveChanged(bool value) async {
    try {
      await updateVendorStatus(vendor.vendorId, value);
    } catch (e) {
      print("error update vendor status");
    }
  }

  void updateVendorTrust(int value) async {
    try {
      await updateVendorTrustLevel(vendor.vendorId, value);
    } catch (e) {
      print(e);
    }
  }

  void saveChange() async {
    Map<String, dynamic> payload = {
      "store_name": nameController.text,
      "store_desc": descController.text,
      "store_logo": logoController.text,
      "vendor_id": vendor.vendorId
    };
    try {
      await updateVendorInf(payload);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateVendorInf(Map<String, dynamic> payload) async {
    final url = Uri.parse(
        'http://192.168.1.100:12321/dashboard_admin/vendor/put_vendoreditInf.php');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        print('تم التحديث بنجاح: $payload');
        print(response.body);
      } else {
        print('فشل التعديل: ${response.statusCode}');
      }
    } catch (e) {
      print('حدث خطأ أثناء الاتصال: $e');
    }
  }

  // تحديث الحالة عبر API
  Future<void> updateVendorStatus(int ids, bool newStatus) async {
    final url = Uri.parse(
        'http://192.168.1.100:12321/dashboard_admin/vendor/put_statusactive.php');
    final payload = {
      "vendor_id": ids,
      "new_status": newStatus.toString(),
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        print('تم التحديث بنجاح: $payload');
        print(response.body);
      } else {
        print('فشل التعديل: ${response.statusCode}');
      }
    } catch (e) {
      print('حدث خطأ أثناء الاتصال: $e');
    }
  }

  Future<void> updateVendorTrustLevel(int ids, int newlevel) async {
    final url = Uri.parse(
        'http://192.168.1.100:12321/dashboard_admin/vendor/put_updateleveltrust.php');
    final payload = {
      "vendor_id": ids,
      "new_level": newlevel,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        print('تم التحديث بنجاح: $payload');
        print(response.body);
      } else {
        print('فشل التعديل: ${response.statusCode}');
      }
    } catch (e) {
      print('حدث خطأ أثناء الاتصال: $e');
    }
  }
}
