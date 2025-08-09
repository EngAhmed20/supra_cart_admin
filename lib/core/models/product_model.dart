
class ProductModel {
  final String? id;
  final String name;
  final double price;
  final double oldPrice;
  final String description;
  final String category;
  late  String imageUrl;

  num getSale({double?priceBeforeDiscount, double? priceAfterDiscount})  {
    final bool usePassedValues =
        priceBeforeDiscount != null && priceBeforeDiscount > 0 &&
            priceAfterDiscount != null && priceAfterDiscount > 0;
    final before = usePassedValues ? priceBeforeDiscount : oldPrice;
    final after = usePassedValues ? priceAfterDiscount : price;

    if (before > 0 && before > after) {
      return ((before - after) / before * 100).truncate();
    }
    return 0;
  }

  ProductModel({
     this.id,
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
  Map<String, dynamic> toJson() {
    return {
      'product_name': name,
      'product_price': price,
      'old_price': oldPrice,
      'description': description,
      'category': category,
      'img_url': imageUrl,
    };
  }
  ProductModel copyWith({
    String? id,
    String? name,
    double? price,
    double? oldPrice,
    String? description,
    String? category,
    String? imageUrl,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      description: description ?? this.description,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }


  static double _parseDouble(dynamic value) {
    if (value == null) return 0;
    return double.tryParse(value.toString()) ?? 0;
  }
}
