

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';
import './edit_product_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final product = Provider.of<ProductProvider>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: const Color(0xFFB497BD), // Lilac AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: const Color(0xFFE6DAF0), // Lilac dialog
                  title: const Text('Are you sure?'),
                  content: const Text('Do you want to delete this product?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(true),
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                Provider.of<ProductProvider>(context, listen: false)
                    .deleteProduct(product.id);
                Navigator.of(context).pop(); // Return to previous screen
              }
            },
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFF3E9F7), // Lilac-ish soft background
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF6A4C93))),
                const SizedBox(height: 12),
                Text(product.description, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 12),
                Text('Cost: ₹${product.cost}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('Quantity: ${product.quantity}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('Category: ${product.category}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('In Stock: ${product.inStock ? 'Yes' : 'No'}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        EditProductScreen.routeName,
                        arguments: product.id,
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Product'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8E7CA8), // Dark lilac
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
