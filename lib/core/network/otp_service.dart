import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_constants.dart';
import 'auth_service.dart';

class OtpService {
  static const Duration timeout = Duration(seconds: 60);

  static Future<Map<String, dynamic>> sendOtp(String email) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/otp/send'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      ).timeout(timeout);
      return jsonDecode(response.body);
    } on SocketException {
      return {'success': false, 'message': 'No internet connection'};
    } catch (e) {
      return {'success': false, 'message': 'Server is waking up, please try again in 30 seconds'};
    }
  }

  static Future<Map<String, dynamic>> verifyOtp(String email, String otp, {String? username}) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/otp/verify'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otp, 'username': username}),
      ).timeout(timeout);
      return jsonDecode(response.body);
    } on SocketException {
      return {'success': false, 'message': 'No internet connection'};
    } catch (e) {
      return {'success': false, 'message': 'Server is waking up, please try again'};
    }
  }
}