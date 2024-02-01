import 'package:flutter/material.dart';

class CategoryListBar extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;
  //final Function(int) onCategoryTap;

  const CategoryListBar({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    //required this.onCategoryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: List.generate(categories.length, (index) {
          return GestureDetector(
            onTap: () {
              onCategorySelected(categories[index]);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: selectedCategory.contains(categories[index])
                    ? const Color.fromARGB(255, 136, 28, 28)
                    : const Color(0xFFFFF8F0),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: selectedCategory.contains(categories[index])
                      ? Colors.white
                      : const Color.fromARGB(255, 136, 28, 28),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
