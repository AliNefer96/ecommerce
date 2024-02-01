import 'package:ecommerce/Helpers/http_helper.dart';
import 'package:ecommerce/Models/categories_model.dart';
import 'package:ecommerce/Models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCategoriesProvider with ChangeNotifier {
  List<String> _categoryList = [];

  List<String> get categories {
    return [..._categoryList];
  }

  Future<List<String>> getCategories() async {
    try {
      var categoryList = await HTTPHelper.getCategoryData();
      _categoryList = categoryList
          .cast<String>()
          .map((category) => _capitalizeFirstLetter(category))
          .toList();

      notifyListeners();
    } catch (error) {
      print('Error fetching categories: $error');
    }

    return _categoryList;
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
