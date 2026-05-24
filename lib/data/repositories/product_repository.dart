import 'package:get/get.dart';
import '../../core/network/api_constants.dart';
import '../models/product_model.dart';

class ProductRepository extends GetConnect {
  Future<List<Product>> getAllProducts() async {
    final response = await get(ApiConstants.baseUrl + ApiConstants.products);
    
    if (response.status.hasError) {
      return Future.error(response.statusText ?? "Error fetching products");
    } else {
      List<dynamic> body = response.body;
      return body.map((item) => Product.fromJson(item)).toList();
    }
  }
}
