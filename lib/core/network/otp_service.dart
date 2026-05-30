import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constants.dart';

class OtpService {
  static Future<Map<String, dynamic>> sendOtp(String email) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/otp/send'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> verifyOtp(String email, String otp, {String? username}) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/otp/verify'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp, 'username': username}),
    );
    return jsonDecode(response.body);
  }
}