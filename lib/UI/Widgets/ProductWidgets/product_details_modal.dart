import 'package:ecommerce/Helpers/http_helper.dart';
import 'package:ecommerce/Models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/UI/Screens/ProductScreens/product_edit_screen.dart';

class ProductDetailsModal extends StatelessWidget {
  final Product productInfo;
  final List<String> categories;
  final VoidCallback onDeletePressed;

  const ProductDetailsModal({
    super.key,
    required this.productInfo,
    required this.categories,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 226, 226, 226),
      height: 250,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            productInfo.title,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.0,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => ProductEditModal(
                          productInfo: productInfo,
                          categories: categories
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit product'),
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 136, 28, 28),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                height: 40.0,
                width: double.infinity,
                color: Colors.white,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await HTTPHelper.deleteProduct(productInfo.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Product successfully deleted!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red[800],
                  ),
                  label: Text(
                    'Delete product',
                    style: TextStyle(color: Colors.red[800]),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red[800]!),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
