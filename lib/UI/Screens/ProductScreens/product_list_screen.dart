// ignore_for_file: avoid_print

import 'package:ecommerce/Helpers/http_helper.dart';
import 'package:ecommerce/Models/product_model.dart';
import 'package:ecommerce/Providers/product_categories_provider.dart';
import 'package:ecommerce/Providers/product_provider.dart';
import 'package:ecommerce/UI/Widgets/category_list_bar.dart';
import 'package:ecommerce/UI/Widgets/ProductWidgets/product_details_modal.dart';
import 'package:ecommerce/UI/Widgets/ProductWidgets/product_list.dart';
import 'package:ecommerce/UI/Widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> allProducts = [];
  List<Product> displayedProducts = [];
  List<String> categories = [];
  String selectedCategory = '';
  int resultCount = 10;
  bool isCategory = false;

  @override
  void initState() {
    super.initState();
    if (selectedCategory != '') {
      isCategory = true;
    }
    fetchAllCategories();
    fetchAllProducts();
  }

  void _updateResultCount(int count) async {
    setState(() {
      resultCount = count;
    });

    await Provider.of<ProductProvider>(context, listen: false)
        .fetchProducts(isCategory, selectedCategory);
  }

  void _updateCategory(String category) async {
    setState(() {
      selectedCategory = category;
      isCategory = true;
    });
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchProducts(isCategory, selectedCategory)
        .then((_) {
      print("Products fetched successfully");
    }).catchError((error) {
      print("Error fetching products: $error");
    });
  }

  void fetchAllProducts() async {
    List<Product> allProducts =
        await Provider.of<ProductProvider>(context, listen: false)
            .fetchProducts(isCategory, selectedCategory);

    setState(() {
      this.allProducts = allProducts;
      displayedProducts = List.from(allProducts);
    });
  }

  void fetchAllCategories() async {
    List<String> allCategories =
        await Provider.of<ProductCategoriesProvider>(context, listen: false)
            .getCategories();

    setState(() {
      categories = allCategories;
    });
  }

  void sortProductsDescendingPerCategory() {
    allProducts.sort((a, b) => a.category!.compareTo(b.category!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text('Products', style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          SearchBar(
            onCategorySelected: _updateCategory,
            onSearchChanged: (value) {
              filterProductsBySearch(value);
            },
            onResultCountChanged: _updateResultCount,
            selectedCategory: selectedCategory,
            count: resultCount,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CategoryListBar(
                categories: categories,
                selectedCategory: selectedCategory,
                onCategorySelected: _updateCategory),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: ProductListWidget(
              products: displayedProducts.take(resultCount).toList(),
              onMoreDetails: (Product product) {
                _showProductDetailsModal(product);
              },
              categories: categories,
            ),
          ),
        ],
      ),
    );
  }

  void filterProductsBySearch(String searchQuery) {
    setState(() {
      displayedProducts = allProducts
          .where((product) =>
              product.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  void _showProductDetailsModal(Product product) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ProductDetailsModal(
          productInfo: product,
          categories: categories,
          onDeletePressed: () async {
            await HTTPHelper.deleteProduct(product.id);
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
