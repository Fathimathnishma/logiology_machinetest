import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logiology_machinetest/features/home/model/product_model.dart';

class ProductService {
  var url = "https://dummyjson.com/products";

  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List products = data['products'];
      return products.map((json) => ProductModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
