import 'dart:convert';
import 'package:ecommerce_flutter/models/dashboard_vendors_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VendorsController extends GetxController {
  // الحالة العامة
  RxList<Vendor> vendors = <Vendor>[].obs;
  RxList<Vendor> filteredVendors = <Vendor>[].obs;
  RxBool isMultiSelectMode = false.obs;
  RxSet<int> selectedVendorIds = <int>{}.obs;

  // التصفية والبحث
  RxString selectedStatus = 'all'.obs;
  RxString selectedDate = 'الأحدث'.obs;
  String? searchQuery;

  // التحميل والصفحات
  RxBool isLoading = false.obs;
  RxInt currentPage = 1.obs;
  RxBool hasMore = true.obs;

  // التوكن الموحد
  static const String authToken =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NTkzMTUwMTYsImV4cCI6MTc1OTMxODYxNiwiZGF0YSI6eyJ1c2VyX2lkIjo2OCwiZW1haWwiOiJhYmRhbG1qZWQyMjJAZ21haWwuY29tIiwicm9sZSI6ImFkbWluIn19.1wwP6n5duLF1KZFSEUHmWjCypRCebBn6Gm7zBP3eyvE';

  @override
  void onInit() {
    super.onInit();
    loadVendors();
  }

  // تحديد متعدد
  void toggleSelection(int vendorId) {
    selectedVendorIds.contains(vendorId)
        ? selectedVendorIds.remove(vendorId)
        : selectedVendorIds.add(vendorId);
  }

  // تنفيذ جماعي
  Future<void> applyBulkAction(String newStatus) async {
    for (var id in selectedVendorIds) {
      final vendor = vendors.firstWhere((v) => v.vendorId == id);
      vendor.status = newStatus;
    }

    await updateVendorStatus(selectedVendorIds.toList(), newStatus);
    selectedVendorIds.clear();
    isMultiSelectMode.value = false;
  }

  // التصفية
  void applyFilter(String status, String date) {
    selectedStatus.value = status;
    selectedDate.value = date;

    final statusParam = status.trim().toLowerCase();

    filteredVendors.assignAll(vendors.where((vendor) {
      final vendorStatus = vendor.status.trim().toLowerCase();
      return statusParam == 'all' || vendorStatus == statusParam;
    }).toList());

    if (date == 'الأحدث') {
      filteredVendors.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (date == 'الأقدم') {
      filteredVendors.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }

    selectedVendorIds.removeWhere(
      (id) => !filteredVendors.any((vendor) => vendor.vendorId == id),
    );
  }

  // تحميل البائعين
  Future<void> loadVendors() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;

    try {
      final newVendors = await fetchVendors(
        page: currentPage.value,
        search: searchQuery,
        status: selectedStatus.value,
      );

      if (newVendors.isEmpty || newVendors.length < 50) {
        hasMore.value = false;
      }

      vendors.addAll(newVendors);
      filteredVendors.assignAll(vendors);
      currentPage.value++;
    } catch (e) {
      print('خطأ في التحميل: $e');
    }

    isLoading.value = false;
  }

  // جلب البائعين من API
  Future<List<Vendor>> fetchVendors({
    required int page,
    String? search,
    String? status,
  }) async {
    final uri = Uri.parse(
            "http://192.168.1.100:12321/dashboard_admin/vendor/get_vendor.php")
        .replace(
      queryParameters: {
        'page': page.toString(),
        'limit': '50',
        if (search != null && search.isNotEmpty) 'search': search,
        if (status != null && status != 'all') 'status': status,
      },
    );

    final response = await http.get(
      uri,
      headers: {
        'Authorization': authToken,
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Vendor>.from(
          data['vendors'].map((item) => Vendor.fromJson(item)));
    } else {
      throw Exception('فشل في جلب البائعين: ${response.statusCode}');
    }
  }

  // إعادة تحميل من البداية
  void resetAndReload() {
    currentPage.value = 1;
    vendors.clear();
    filteredVendors.clear();
    hasMore.value = true;
    loadVendors();
  }

  // تحديث الحالة عبر API
  Future<void> updateVendorStatus(List<int> ids, String newStatus) async {
    final url = Uri.parse(
        'http://192.168.1.102:12321/dashboard_admin/put_status_users.php');
    final payload = {
      "vendor_id": ids,
      "status": newStatus,
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
        resetAndReload();
      } else {
        print('فشل التعديل: ${response.statusCode}');
      }
    } catch (e) {
      print('حدث خطأ أثناء الاتصال: $e');
    }
  }
}
