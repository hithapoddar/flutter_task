


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../providers/product_provider.dart';
import './add_product_screen.dart';
import './product_detail_screen.dart';
import '../models/product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFE6DAF0),
        title: const Text(
          'ORGANIX',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Color(0xFF4B1E6D),
            letterSpacing: 1.5,
            shadows: [
              Shadow(
                blurRadius: 4.0,
                color: Color(0xFF957DAD),
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SmartRefresher(
        controller: RefreshController(),
        onRefresh: () async {
          await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
        },
        child: FutureBuilder(
          future: Provider.of<ProductProvider>(context, listen: false).fetchProducts(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return const Center(child: Text('Error fetching products'));
            } else {
              return Consumer<ProductProvider>(
                builder: (ctx, productProvider, child) {
                  return Column(
                    children: [
                      _buildSeasonalTip(),
                      _buildCategoryChips(context, productProvider),
                      Expanded(
                        child: MasonryGridView.count(
                          crossAxisCount: 2,
                          itemCount: productProvider.filteredProducts.length,
                          itemBuilder: (ctx, index) {
                            final product = productProvider.filteredProducts[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  ProductDetailScreen.routeName,
                                  arguments: product.id,
                                );
                              },
                              child: Card(
                                elevation: 3,
                                margin: const EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: _getPastelColor(product.category),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(_getCategoryImage(product.category)),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '${_getEmoji(product.category)} ${product.name}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4A3E5A),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "Qty: ${product.quantity}",
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                      Text(
                                        "₹${product.cost.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xFF5C4B7D),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Chip(
                                        label: Text(
                                          product.category,
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: const Color(0xFFB497BD),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFB497BD),
        onPressed: () {
          Navigator.of(context).pushNamed(AddProductScreen.routeName);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSeasonalTip() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        children: [
          Icon(Icons.wb_sunny, color: Color(0xFFFFAD60)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "🍊 Today’s Tip: Oranges are great for glowing skin!",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(BuildContext context, ProductProvider productProvider) {
    final categories = ['Fruit', 'Vegetable', 'Dairy', 'Grain', 'Other'];

    return Container(
      height: 40,
      margin: const EdgeInsets.only(left: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // "All" button first
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: _buildAllButton(context, productProvider),
          ),
          // Category buttons
          ...categories.map((category) {
            return Container(
              margin: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  productProvider.filterProductsByCategory(category);
                },
                child: Chip(
                  label: Text(category),
                  backgroundColor: const Color(0xFFDCC6E0),
                  labelStyle: const TextStyle(color: Colors.black87),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAllButton(BuildContext context, ProductProvider productProvider) {
    return GestureDetector(
      onTap: () {
        productProvider.resetFilter();
      },
      child: Chip(
        label: const Text('All'),
        backgroundColor: const Color(0xFFDCC6E0),
        labelStyle: const TextStyle(color: Colors.black87),
      ),
    );
  }

  String _getCategoryImage(String category) {
    switch (category) {
      case 'Fruit':
        return 'assets/images/fruit.jpg';
      case 'Vegetable':
        return 'assets/images/vegetable.jpg';
      case 'Dairy':
        return 'assets/images/dairy.jpg';
      case 'Grain':
        return 'assets/images/grain.jpg';
      default:
        return 'assets/images/other.jpg';
    }
  }

  Color _getPastelColor(String category) {
    switch (category) {
      case 'Fruit':
        return const Color(0xFFFFEBF0);
      case 'Vegetable':
        return const Color(0xFFE5FFE5);
      case 'Dairy':
        return const Color(0xFFF5F5DC);
      case 'Grain':
        return const Color(0xFFFFF7E6);
      default:
        return const Color(0xFFF2E5FF);
    }
  }

  String _getEmoji(String category) {
    switch (category) {
      case 'Fruit':
        return '🍎';
      case 'Vegetable':
        return '🥬';
      case 'Dairy':
        return '🥛';
      case 'Grain':
        return '🌾';
      default:
        return '🍽️';
    }
  }
}
