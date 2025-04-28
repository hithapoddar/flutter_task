

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product';

  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costController = TextEditingController();
  final _quantityController = TextEditingController();
  String _category = 'Fruit';
  bool _inStock = true;

  void _saveForm() {
    if (!_formKey.currentState!.validate()) return;

    final newProduct = Product(
      id: '',
      name: _nameController.text,
      description: _descriptionController.text,
      cost: double.parse(_costController.text),
      category: _category,
      inStock: _inStock,
      quantity: int.parse(_quantityController.text),
    );

    Provider.of<ProductProvider>(context, listen: false).addProduct(newProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E9F7), // Soft lilac background
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: const Color(0xFFB497BD), // Lilac AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      labelStyle: TextStyle(color: Color(0xFF6A4C93)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF6A4C93)),
                      ),
                    ),
                    validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Color(0xFF6A4C93)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF6A4C93)),
                      ),
                    ),
                    validator: (value) => value!.isEmpty ? 'Enter a description' : null,
                  ),
                  TextFormField(
                    controller: _costController,
                    decoration: const InputDecoration(
                      labelText: 'Cost',
                      labelStyle: TextStyle(color: Color(0xFF6A4C93)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF6A4C93)),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => double.tryParse(value!) == null ? 'Enter a valid cost' : null,
                  ),
                  TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                      labelStyle: TextStyle(color: Color(0xFF6A4C93)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF6A4C93)),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => int.tryParse(value!) == null ? 'Enter a valid quantity' : null,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Category',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF6A4C93)),
                  ),
                  DropdownButton<String>(
                    value: _category,
                    isExpanded: true,
                    iconEnabledColor: const Color(0xFF6A4C93),
                    dropdownColor: const Color(0xFFF3E9F7),
                    onChanged: (val) => setState(() => _category = val!),
                    items: ['Fruit', 'Vegetable', 'Dairy', 'Grain', 'Other']
                        .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                        .toList(),
                  ),
                  SwitchListTile(
                    title: const Text('In Stock', style: TextStyle(color: Color(0xFF6A4C93))),
                    activeColor: const Color(0xFF8E7CA8),
                    value: _inStock,
                    onChanged: (val) => setState(() => _inStock = val),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8E7CA8), // Button lilac
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Save Product', style: TextStyle(fontSize: 16)),
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
