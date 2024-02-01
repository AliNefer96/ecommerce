import 'package:ecommerce/Models/product_model.dart';
import 'package:flutter/material.dart';
import '../../Screens/ProductScreens/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final List<String> categories;
  final VoidCallback onMoreDetails;

  const ProductCard({
    Key? key,
    required this.categories,
    required this.product,
    required this.onMoreDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Card(
      color: const Color.fromARGB(255, 226, 226, 226),
      elevation: 2.0,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${product.category}'.toUpperCase(),
              style: const TextStyle(
                fontSize: 11.0,
                color: Color.fromARGB(255, 103, 103, 103),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                product.title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 136, 28, 28),
                ),
              ),
            ),
          ],
        ),
        subtitle: Text(
          '\$${product.price.toString()}',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        leading: SizedBox(
          height: 100,
          width: 80,
          child: Image.network(
            '${product.image}',
            fit: BoxFit.cover,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert_rounded),
          onPressed: () {
            onMoreDetails();
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                productInfo: product,
                categories: categories,
              ),
            ),
          );
        },
      ),
    );
  }
}
