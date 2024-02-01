import 'package:ecommerce/Models/product_model.dart';
import 'package:ecommerce/UI/Widgets/ProductWidgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductListWidget extends StatelessWidget {
  final List<Product> products;
  final List<String> categories;
  final void Function(Product) onMoreDetails;

  const ProductListWidget({
    Key? key,
    required this.products,
    required this.categories,
    required this.onMoreDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onMoreDetails: () {
            onMoreDetails(products[index]);
          },
          categories: categories,
        );
      },
    );
  }
}
