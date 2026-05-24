class Product {
  final int? id;
  final String name;
  final String description;
  final String price;
  final String imagePath;
  final String unit;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.unit,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '0.00',
      imagePath: json['image_path'] ?? '',
      unit: json['unit'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image_path': imagePath,
      'unit': unit,
    };
  }
}
