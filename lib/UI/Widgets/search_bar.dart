import 'package:ecommerce/UI/Widgets/filter_modal.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  final Function(int) onResultCountChanged;
  final String selectedCategory;
  final Function(String) onCategorySelected;
  int count;

  SearchBar({super.key, 
    required this.onSearchChanged,
    required this.onResultCountChanged,
    required this.count,
    required this.selectedCategory,
    required this.onCategorySelected
   
  });

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8F0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search, color: Color.fromARGB(255, 136, 28, 28)),
                    onPressed: () {
                      // Handle search button press
                    },
                  ),
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(color: Color.fromARGB(255, 136, 28, 28)),
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Color.fromARGB(255, 136, 28, 28)),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        onSearchChanged(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Container(
            width: 40.0,
            height: 40.0,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF8F0),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.filter_alt_outlined, color: Color.fromARGB(255, 136, 28, 28)),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return  FilterModal(
                      onResultCountChanged: onResultCountChanged,
                      count: count,
                      priceSortOption: PriceSortOption.highest,
                      selectedCategory: selectedCategory,
                       onCategorySelected: onCategorySelected,
                    
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
