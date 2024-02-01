// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:ecommerce/Helpers/http_helper.dart';
import 'package:ecommerce/Models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Product> _productList = [];

  List<Product> get products {
    return [..._productList];
  }

  Future<List<Product>> fetchProducts(bool isCategory, String category) async {
    if (isCategory == false) {
      var productList = await HTTPHelper.getProducts();

      _productList = productList
          .map((e) => Product(
              id: e['id'] ?? 0,
              title: e['title'] ?? '',
              price: (e['price'] ?? 0.0).toDouble(),
              description: e['description'] ?? '',
              category: e['category'] ?? '',
              image: e['image'] ?? '',
              rating: (e['rating']['rate'] ?? 0.0).toDouble()))
          .toList();
    } else {
      var productList = await HTTPHelper.getProductsByCategory(category);

      _productList = productList
          .map((e) => Product(
              id: e['id'] ?? 0,
              title: e['title'] ?? '',
              price: (e['price'] ?? 0.0).toDouble(),
              description: e['description'] ?? '',
              category: e['category'] ?? '',
              image: e['image'] ?? '',
              rating: (e['rating']['rate'] ?? 0.0).toDouble()))
          .toList();
    }
    notifyListeners();
    sortProductsDescendingAlphabetically();

    return _productList;
  }

  void sortProductsDescendingAlphabetically() {
    _productList.sort((a, b) => a.category!.compareTo(b.category!));
  }

  Future<void> updateProductData(
      int productID, Map<String, dynamic> newData) async {
    var result;
    try {
      result = await HTTPHelper.updateProductData(productID, newData);
      if (result == 200) {
        print('Succesfully sent $newData');
      }
    } catch (error) {
      print('Error updating data: $error');
    }
    notifyListeners();
  }
}
