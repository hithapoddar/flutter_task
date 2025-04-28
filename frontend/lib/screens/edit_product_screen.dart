


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  const EditProductScreen({super.key});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late String _productId;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costController = TextEditingController();
  final _quantityController = TextEditingController();
  String _category = 'Fruit';
  bool _inStock = true;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      _productId = productId;
      final product = Provider.of<ProductProvider>(context, listen: false).findById(productId);

      _nameController.text = product.name;
      _descriptionController.text = product.description;
      _costController.text = product.cost.toString();
      _quantityController.text = product.quantity.toString();
      _category = product.category;
      _inStock = product.inStock;

      _isInit = false;
    }
  }

  void _saveForm() {
    if (!_formKey.currentState!.validate()) return;

    final updatedProduct = Product(
      id: _productId,
      name: _nameController.text,
      description: _descriptionController.text,
      cost: double.parse(_costController.text),
      category: _category,
      inStock: _inStock,
      quantity: int.parse(_quantityController.text),
    );

    // Save product update
    Provider.of<ProductProvider>(context, listen: false).updateProduct(updatedProduct);
    
    // Show Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Product Updated!'),
        backgroundColor: Color(0xFF6DC24B),
      ),
    );

    Navigator.of(context).pop();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.deepPurple.shade50,
      labelStyle: const TextStyle(color: Colors.deepPurple),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.deepPurple.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lilac = Colors.deepPurple.shade100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        backgroundColor: Color(0xFFA084CA),
      ),
      body: Container(
        color: lilac.withOpacity(0.2),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration('Product Name'),
                validator: (value) => value!.isEmpty ? 'Enter a name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: _inputDecoration('Description'),
                validator: (value) => value!.isEmpty ? 'Enter a description' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _costController,
                decoration: _inputDecoration('Cost'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    double.tryParse(value!) == null ? 'Enter a valid cost' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _quantityController,
                decoration: _inputDecoration('Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    int.tryParse(value!) == null ? 'Enter a valid quantity' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: _inputDecoration('Category'),
                onChanged: (val) => setState(() => _category = val!),
                items: ['Fruit', 'Vegetable', 'Dairy', 'Grain', 'Other']
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text('In Stock'),
                activeColor: Colors.deepPurple,
                value: _inStock,
                onChanged: (val) => setState(() => _inStock = val),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA084CA),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: const Text('Update Product', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
