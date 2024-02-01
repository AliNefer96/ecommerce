// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:ecommerce/Models/product_model.dart';
import 'package:ecommerce/Providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductEditModal extends StatefulWidget {
  final Product productInfo;
  final List<String> categories;

  const ProductEditModal({super.key, 
    
    required this.productInfo,
    required this.categories,
  });
  
  @override
  // ignore: library_private_types_in_public_api
  _ProductEditModalState createState() => _ProductEditModalState();
}

class _ProductEditModalState extends State<ProductEditModal> {
  String selectedCategory = '';
  File? _pickedImage;
  late TextEditingController titleController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  List<String> lowerCaseList = [];
 
 
  List<String> convertListToLowerCase(List<String> inputList) {
  List<String> lowerCaseList = inputList.map((element) => element.toLowerCase()).toList();
  return lowerCaseList;
}

  void handleCategoryChange(String? newCategory) {
    setState(() {
      selectedCategory = newCategory ?? '';
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    lowerCaseList = convertListToLowerCase(widget.categories);
    titleController = TextEditingController(text: widget.productInfo.title);
    priceController = TextEditingController(text: widget.productInfo.price.toString());
    descriptionController = TextEditingController(text: widget.productInfo.description);
    selectedCategory = widget.productInfo.category!;
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height + 16,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.productInfo.title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 136, 28, 28),
                  ),
                ),
                const Divider(),
                const Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8F0),
                    border: Border.all(color:const Color.fromARGB(255, 148, 125, 98)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter product title',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Price',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF8F0),
                              border: Border.all(
                                color:const Color.fromARGB(255, 148, 125, 98),
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: priceController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF8F0),
                              border: Border.all(
                                color:const Color.fromARGB(255, 148, 125, 98),
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField<String>(
                                value: widget.productInfo.category,
                                items: lowerCaseList.map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(category),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  handleCategoryChange(value);
                                },
                                decoration: InputDecoration(
                                  hintText: widget.productInfo.category,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8F0),
                    border: Border.all(
                      color: const Color.fromARGB(255, 148, 125, 98),
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: descriptionController,
                      maxLines: 8,
                      decoration: const InputDecoration(
                        hintText: 'Enter product description',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14.0),
                const Text(
                  'Image',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:const Color.fromARGB(255, 136, 28, 28),
                                width: 1.0,
                              ),
                            ),
                            child: ClipOval(
                              child: _pickedImage != null
                                  ? Image.file(
                                      _pickedImage!,
                                      height: 100,
                                      width: 100,
                                    )
                                  : widget.productInfo.image.isNotEmpty
                                      ? Image.network(
                                          widget.productInfo.image,
                                          height: 100,
                                          width: 100,
                                        )
                                      : Container(
                                          height: 100,
                                          width: 100,
                                          color: Colors.grey,
                                        ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    InkWell(
                      onTap: _pickImage,
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 136, 28, 28),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Divider(),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 136, 28, 28),
                          ),
                        ),
                        onPressed: () {
                          saveDataToApi();
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.red[800]!,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
          ),
        ),
      ),
    );
  }

  Future<void> saveDataToApi() async {
    Map<String, dynamic> newData = {
      'title': titleController.text,
      'price': double.parse(priceController.text),
      'category': selectedCategory,
      'description': descriptionController.text,
    };

    await Provider.of<ProductProvider>(context, listen: false)
        .updateProductData(widget.productInfo.id, newData);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product successfully updated!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }
 
}
