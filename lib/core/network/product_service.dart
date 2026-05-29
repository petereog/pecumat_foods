import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constants.dart';
import 'auth_service.dart';

class ProductService {
  static Future<List<dynamic>> getProducts({String? category, String? search}) async {
    String url = '${ApiConstants.baseUrl}${ApiConstants.products}';

    final queryParams = <String, String>{};
    if (category != null) queryParams['category'] = category;
    if (search != null) queryParams['search'] = search;

    if (queryParams.isNotEmpty) {
      url += '?${queryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}';
    }

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    if (data['success'] == true) {
      return data['products'];
    }
    return [];
  }

  static Future<Map<String, dynamic>> getProduct(String id) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.products}/$id'),
    );
    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> getCategories() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.categories}'),
    );
    final data = jsonDecode(response.body);
    if (data['success'] == true) {
      return data['categories'];
    }
    return [];
  }

  static Future<Map<String, dynamic>> addToFavourites(String productId) async {
    final token = await AuthService.getToken();
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.favourites}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'productId': productId}),
    );
    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> getFavourites() async {
    final token = await AuthService.getToken();
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.favourites}'),
      headers: {'Authorization': 'Bearer $token'},
    );
    final data = jsonDecode(response.body);
    if (data['success'] == true) {
      return data['products'];
    }
    return [];
  }
}