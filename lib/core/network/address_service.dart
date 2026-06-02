import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constants.dart';
import 'auth_service.dart';

class AddressService {
  static Future<Map<String, dynamic>> addAddress({
    required String label,
    required String street,
    required String city,
    required String state,
    required String zipCode,
    required String country,
    bool isDefault = false,
  }) async {
    final token = await AuthService.getToken();
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addresses}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'label': label,
        'street': street,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'country': country,
        'isDefault': isDefault,
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> getAddresses() async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addresses}'),
      headers: {'Authorization': 'Bearer $token'},
    );
    final data = jsonDecode(response.body);
    if (data['success'] == true) return data['addresses'];
    return [];
  }

  static Future<Map<String, dynamic>> deleteAddress(String id) async {
    final token = await AuthService.getToken();
    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addresses}/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> setDefault(String id) async {
    final token = await AuthService.getToken();
    final response = await http.patch(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addresses}/$id/default'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return jsonDecode(response.body);
  }
}