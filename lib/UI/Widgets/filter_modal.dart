import 'package:ecommerce/Models/product_model.dart';
import 'package:ecommerce/UI/Widgets/category_list_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/product_categories_provider.dart';

enum PriceSortOption {
  highest,
  lowest,
}

// ignore: must_be_immutable
class FilterModal extends StatefulWidget {
  final Function(int) onResultCountChanged;
  int count;
  PriceSortOption priceSortOption;
  final String selectedCategory;
  final Function(String) onCategorySelected;
  
  FilterModal({
    super.key,
    required this.onResultCountChanged,
    required this.count,
    required this.priceSortOption,
    required this.selectedCategory,
    required this.onCategorySelected
  });

  @override
  // ignore: library_private_types_in_public_api
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  List<String> categories = [];
  List<Product> allProducts = [];
  List<Product> displayedProducts = [];

  @override
  void initState() {
    super.initState();
  }

  // void filterProductsByCategories() {
  //   setState(() {
  //     if (widget.selectedCategory.isEmpty) {
  //       displayedProducts = List.from(allProducts);
  //     } else {
  //       displayedProducts = allProducts.where((product) {
  //        return true;
         
  //       }).toList();
  //     }

  //     applySorting();
  //   });
  // }

  // void applySorting() {
  //   if (widget.priceSortOption == PriceSortOption.highest) {
  //     displayedProducts.sort((a, b) => b.price.compareTo(a.price));
  //   } else if (widget.priceSortOption == PriceSortOption.lowest) {
  //     displayedProducts.sort((a, b) => a.price.compareTo(b.price));
  //   }

  //   sortProductsDescendingAlphabetically();
  // }

  // void sortProductsDescendingAlphabetically() {
  //   displayedProducts.sort((a, b) => a.category!.compareTo(b.category!));
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'Filter',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Category:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          FutureBuilder(
            future:
                Provider.of<ProductCategoriesProvider>(context, listen: false)
                    .getCategories(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else {
                if (snapshot.error != null) {
                  return const Center(
                    child: Text('An error occured'),
                  );
                }
                return Consumer<ProductCategoriesProvider>(
                    builder: (context, categoryList, child) {
                  return CategoryListBar(
                    categories: categoryList.categories,
                    selectedCategory: widget.selectedCategory,
                    onCategorySelected:
                    
                     widget.onCategorySelected,
                    // onCategoryTap: (index) {
                    //   setState(() {
                    //     // if (widget.selectedCategory.contains(index)) {
                    //     //   widget.selectedCategory.remove(index);
                    //     // } else {
                    //     //   widget.selectedCategory.add(index);
                    //     // }
                    //     widget
                    //         .onCategorySelected(widget.selectedCategory as Set<int>);
                    //     filterProductsByCategories();
                    //   });
                    // },
                  );
                });
              }
            },
          ),
          const SizedBox(height: 16.0),
          _buildPriceSortOptions(),
          const SizedBox(height: 16.0),
          _buildResultCountOptions(),
          const SizedBox(height: 16.0),
          const Divider(
            thickness: 2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 40.0,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 136, 28, 28),
                  ),
                  child: const Text('Apply Filters'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40.0,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSortOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Sort by Price:',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.priceSortOption = PriceSortOption.highest;
                 // applySorting();
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.priceSortOption == PriceSortOption.highest
                        ? const Color.fromARGB(255, 136, 28, 28)
                        : Colors.transparent,
                  ),
                  color: const Color(0xFFFFF8F0),
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.arrow_downward,
                      color: Color.fromARGB(255, 136, 28, 28),
                    ),
                    SizedBox(width: 8.0),
                    Text('Highest Price',
                        style: TextStyle(
                          color: Color.fromARGB(255, 136, 28, 28),
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.priceSortOption = PriceSortOption.lowest;
                 // applySorting();
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.priceSortOption == PriceSortOption.lowest
                        ? const Color.fromARGB(255, 136, 28, 28)
                        : Colors.transparent,
                  ),
                  color: const Color(0xFFFFF8F0),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.arrow_upward,
                      color: Color.fromARGB(255, 136, 28, 28),
                    ),
                    SizedBox(width: 8.0),
                    Text('Lowest Price',
                        style: TextStyle(
                          color: Color.fromARGB(255, 136, 28, 28),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResultCountOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Number of Results:',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildResultCountButton(5),
            const SizedBox(
              width: 6,
            ),
            _buildResultCountButton(10),
            const SizedBox(
              width: 6,
            ),
            _buildResultCountButton(20),
            const SizedBox(
              width: 6,
            ),
            _buildResultCountButton(30),
          ],
        ),
      ],
    );
  }

  Widget _buildResultCountButton(int count) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.count = count;
          widget.onResultCountChanged(widget.count);
         // filterProductsByCategories();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.count == count
                ? const Color.fromARGB(255, 136, 28, 28)
                : Colors.transparent,
          ),
          color: const Color(0xFFFFF8F0),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Text('$count',
            style: const TextStyle(
              color: Color.fromARGB(255, 136, 28, 28),
            )),
      ),
    );
  }
}
