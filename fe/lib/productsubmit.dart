import 'package:flutter/material.dart';
import 'package:smilestone/constants/app_colors.dart';

class ProductSubmissionScreen extends StatelessWidget {
  ProductSubmissionScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController specificationsController = TextEditingController();
  String? selectedCategory;
  final List<String> categories = ["Electronics", "Watches", "Books", "Furniture", "Clothing"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Product Submission",
              style: TextStyle(
                fontSize: 30,
                color: greenButtonColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 14),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: productNameController,
                    decoration: InputDecoration(
                      hintText: 'Product Name*',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the product name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: InputDecoration(
                      hintText: 'Select Product Category*',
                      border: OutlineInputBorder(),
                    ),
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedCategory = newValue;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the existing screen for capturing the image
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Tap to select product image',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(
                      hintText: 'Price*',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the price';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: specificationsController,
                    decoration: InputDecoration(
                      hintText: 'Specifications*',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter specifications';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle product submission logic here
                        Navigator.pushReplacementNamed(context, '/home'); // Navigate as needed
                      }
                    },
                    child: Text('Submit Product'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}