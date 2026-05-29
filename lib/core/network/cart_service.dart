import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constants.dart';
import 'auth_service.dart';

class CartService {
  static Future<Map<String, dynamic>> getCart() async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.cart}'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> addToCart(String productId, int quantity) async {
    final token = await AuthService.getToken();
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.cart}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'productId': productId, 'quantity': quantity}),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> removeFromCart(String productId) async {
    final token = await AuthService.getToken();
    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.cart}/$productId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> clearCart() async {
    final token = await AuthService.getToken();
    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.cart}/clear'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return jsonDecode(response.body);
  }
}