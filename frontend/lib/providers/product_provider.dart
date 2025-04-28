import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final String _baseUrl = 'http://localhost:3000/products';

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  String _selectedCategory = ''; // Track selected category

  List<Product> get filteredProducts => _selectedCategory.isEmpty ? _products : _filteredProducts;

  // Filter products by selected category
  void filterProductsByCategory(String category) {
    _selectedCategory = category;
    _filteredProducts = _products
        .where((product) => product.category.toLowerCase() == category.toLowerCase())
        .toList();
    notifyListeners();
  }

  // Reset filter to show all products
  void resetFilter() {
    _selectedCategory = '';
    _filteredProducts = [];
    notifyListeners();
  }

  // Fetch all products from server
  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      _products = data.map((item) => Product.fromJson(item)).toList();

      // Reapply filter if needed
      if (_selectedCategory.isNotEmpty) {
        filterProductsByCategory(_selectedCategory);
      } else {
        notifyListeners();
      }
    } else {
      throw Exception('Failed to load products');
    }
  }

  Product findById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }

  // Delete product
  Future<void> deleteProduct(String productId) async {
    final url = '$_baseUrl/$productId';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      _products.removeWhere((prod) => prod.id == productId);
      _filteredProducts.removeWhere((prod) => prod.id == productId);
      notifyListeners();
    } else {
      throw Exception('Failed to delete product');
    }
  }

  // Add new product
  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': product.name,
        'description': product.description,
        'cost': product.cost,
        'category': product.category,
        'inStock': product.inStock,
        'quantity': product.quantity,
      }),
    );

    if (response.statusCode == 201) {
      final newProduct = Product.fromJson(json.decode(response.body));
      _products.add(newProduct);

      // Add to filtered list only if category matches current filter
      if (_selectedCategory.isNotEmpty &&
          newProduct.category.toLowerCase() == _selectedCategory.toLowerCase()) {
        _filteredProducts.add(newProduct);
      }

      notifyListeners();
    } else {
      throw Exception('Failed to add product');
    }
  }

  // Update existing product
  Future<void> updateProduct(Product product) async {
    final url = '$_baseUrl/${product.id}';
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': product.name,
        'description': product.description,
        'cost': product.cost,
        'category': product.category,
        'inStock': product.inStock,
        'quantity': product.quantity,
      }),
    );

    if (response.statusCode == 200) {
      final index = _products.indexWhere((prod) => prod.id == product.id);
      if (index != -1) {
        _products[index] = product;
      }

      final filteredIndex =
          _filteredProducts.indexWhere((prod) => prod.id == product.id);
      if (filteredIndex != -1) {
        _filteredProducts[filteredIndex] = product;
      }

      notifyListeners();
    } else {
      throw Exception('Failed to update product');
    }
  }
}
