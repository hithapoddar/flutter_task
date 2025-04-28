

class Product {
  final String id;
  final String name;
  final String description;
  final double cost;
  final String category;
  final bool inStock;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.category,
    required this.inStock,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      cost: (json['cost'] as num).toDouble(), // Safely handles both int & double
      category: json['category'],
      inStock: json['inStock'],
      quantity: json['quantity'],
    );
  }
}

