import 'package:ecommerce/Models/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HTTPHelper {
  static const String url = 'https://fakestoreapi.com';

  static Future<List<dynamic>> getCategoryData() async {
    final response = await http.get(Uri.parse('$url/products/categories'));
    List<dynamic> responseBody;
    if (response.statusCode == 200) {
      responseBody = json.decode(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
    return responseBody;
  }

  static Future<List<dynamic>> getProducts() async {
    final response = await http.get(Uri.parse('$url/products'));
    List<dynamic> productList;
    if (response.statusCode == 200) {
      productList = json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
    return productList;
  }

  static Future<List<dynamic>> getProductsByCategory(String category) async {
    final response =
        await http.get(Uri.parse('$url/products/category/$category'));
    List<dynamic> categoryProducts;
    if (response.statusCode == 200) {
      categoryProducts = json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
    return categoryProducts;
  }

  static Future<void> deleteProduct(int productId) async {
    final response = await http.delete(Uri.parse('$url/products/$productId'));

    if (response.statusCode == 200) {
      print('Product deleted successfully');
    } else {
      print('Failed to delete product. Status code: ${response.statusCode}');
    }
  }

  static Future<int> updateProductData(
      int productID, Map<String, dynamic> newData) async {
    final String response = '$url/products/$productID';
    var result;

    try {
      result = await http.put(
        Uri.parse(response),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(newData),
      );
    } catch (error) {
      print('Error updating data: $error');
    }
    return result.statusCode;
  }
}
