
class ProductModel {
  final String id;
  final String name;
  final double price;
  final double oldPrice;
  final String description;
  final String category;
  final String imageUrl;

  num get sale {
    if (oldPrice > 0 && oldPrice > price) {
      return ((oldPrice - price) / oldPrice * 100).truncate();
    }
    return 0;
  }

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.description,
    required this.category,
    required this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['product_id'] ?? '',
      name: json['product_name'] ?? '',
      price: _parseDouble(json['product_price']),
      oldPrice: _parseDouble(json['old_price']),
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['img_url'] ?? '',

    );
  }


  static double _parseDouble(dynamic value) {
    if (value == null) return 0;
    return double.tryParse(value.toString()) ?? 0;
  }
}
