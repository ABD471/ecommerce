import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> postRequest({
    required String url,
    required Map<String, dynamic> data,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(data),
          )
          .timeout(timeout);

      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(response.body),
      };
    } on SocketException {
      throw Exception("📴 لا يوجد اتصال بالإنترنت");
    } on TimeoutException {
      throw Exception("⏳ مهلة منتهية");
    } catch (e) {
      throw Exception("❌ خطأ غير متوقع: $e");
    }
  }
}
