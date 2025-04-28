import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.local_offer),
      title: Text(product.name),
      subtitle: Text('Cost: \$${product.cost}'),
      trailing: IconButton(
        icon: const Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: product.id,
          );
        },
      ),
    );
  }
}
