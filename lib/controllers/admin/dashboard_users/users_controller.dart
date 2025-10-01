import 'dart:convert';

import 'package:ecommerce_flutter/models/dashboard_users_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsersController extends GetxController {
  RxList<User> users = <User>[].obs;
  RxList<User> filteredUsers = <User>[].obs;
  RxBool isMultiSelectMode = false.obs;
  RxSet<String> selectedEmails = <String>{}.obs;
  RxString selectedStatus = 'all'.obs;
  RxString selectedDate = 'الأحدث'.obs;
  RxString selectedRole = 'all'.obs;
  RxBool isloading = false.obs;
  RxInt currentPage = 1.obs;
  RxBool hasMore = true.obs;
  String? searchQuery;

  @override
  void onInit() async {
    await loadUsers();
    ();
    super.onInit();
  }

  //////////////////////////////////////////////
  void toggleSelection(String email) {
    selectedEmails.contains(email)
        ? selectedEmails.remove(email)
        : selectedEmails.add(email);
  }

///////////////////////////////////////////////////////
  void applyBulkAction(String newStatus) async {
    for (var email in selectedEmails) {
      final user = users.firstWhere((u) => u.email == email);
      user.status = newStatus;
    }
    print(selectedEmails);
    await updateUserStatus(selectedEmails.toList(), newStatus);

    selectedEmails.clear();
    isMultiSelectMode.value = false;
  }

  /////////////////////////////////////////////////////////
  void applyFilter(String status, String date, String role) {
    selectedStatus.value = status;
    selectedDate.value = date;
    selectedRole.value = role;
    final sParam = (status ?? '').trim().toLowerCase();
    final rParam = (role ?? '').trim().toLowerCase();

    filteredUsers.assignAll(users.where((user) {
      final uStatus = user.status.trim().toLowerCase();
      final uRole = user.role.trim().toLowerCase();

      final statusMatches = sParam == 'all' || sParam == uStatus;
      final roleMatches = rParam == 'all' || rParam == uRole;

      return statusMatches && roleMatches;
    }).toList());

    filteredUsers.refresh();

    if (date == 'الأحدث') {
      filteredUsers.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (date == 'الأقدم') {
      filteredUsers.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }

    selectedEmails.removeWhere(
        (email) => !filteredUsers.any((user) => user.email == email));
  }

  Future<void> loadUsers() async {
    if (isloading.value || !hasMore.value) return;

    isloading.value = true;

    try {
      final newUsers = await fetchUsers(
        page: currentPage.value,
        search: searchQuery,
        status: selectedStatus.value,
        role: selectedRole.value,
      );

      if (newUsers.isEmpty) {
        users.addAll(newUsers);
        filteredUsers.assignAll(users);
        hasMore.value = false;
      } else {
        users.addAll(newUsers);
        currentPage.value++;
        filteredUsers.assignAll(users);
        hasMore.value = false;
      }
    } catch (e) {
      print('خطأ في التحميل: $e');
      isloading.value = false;
    }

    isloading.value = false;
  }

  Future<List<User>> fetchUsers({
    required int page,
    String? search,
    String? status,
    String? role,
  }) async {
    final uri =
        Uri.parse("http://192.168.1.102:12321/dashboard_admin/get_users.php")
            .replace(
      queryParameters: {
        'page': page.toString(),
        'limit': '50',
        if (search != null && search.isNotEmpty) 'search': search,
        if (status != null && status != 'all') 'status': status,
        if (role != null && role != 'all') 'role': role,
      },
    );

    final response = await http.get(
      uri,
      headers: {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NTkxOTkxNDksImV4cCI6MTc1OTIwMjc0OSwiZGF0YSI6eyJ1c2VyX2lkIjo2NywiZW1haWwiOiJkYmFhbG1qZWQyMDA0QGdtYWlsLmNvbSIsInJvbGUiOiJhZG1pbiJ9fQ.gUjfbvxebhfwp3jB9uk0qXshvwHYcPpfpPil12fg-A4',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<User>.from(data['users'].map((item) => User.fromJson(item)));
    } else {
      throw Exception('فشل في جلب المستخدمين: ${response.statusCode}');
    }
  }

  void resetAndReload() {
    currentPage.value = 1;
    users.clear();
    filteredUsers.clear();
    hasMore.value = true;
    loadUsers();
  }

  Future<void> updateUserStatus(List<String> emails, String newstatus) async {
    final url = Uri.parse(
        'http://192.168.1.102:12321/dashboard_admin/put_status_users.php'); // غيّر الرابط حسب عنوان السيرفر
    final payload = {
      "emails": emails,
      "status": newstatus, // يمكن أن تكون "active" أو "unactive"
    };
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NTkxOTkxNDksImV4cCI6MTc1OTIwMjc0OSwiZGF0YSI6eyJ1c2VyX2lkIjo2NywiZW1haWwiOiJkYmFhbG1qZWQyMDA0QGdtYWlsLmNvbSIsInJvbGUiOiJhZG1pbiJ9fQ.gUjfbvxebhfwp3jB9uk0qXshvwHYcPpfpPil12fg-A4',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        print(jsonEncode(payload));
        resetAndReload();
      } else {
        print('فشل التعديل: ${response.statusCode}');
      }
    } catch (e) {
      print('حدث خطأ أثناء الاتصال: $e');
    }
  }

  void onDismissedStarttoend(email) async {
    List<String> emails = [email];
    String newstatus = "unactive";

    await updateUserStatus(emails, newstatus);
  }

  void onDismissedendtostart(email) async {
    List<String> emails = [email];
    String newstatus = "active";

    await updateUserStatus(emails, newstatus);
  }
}
