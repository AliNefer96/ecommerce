class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  final String? description;
  final String? category;
  final double? rating;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.image,
      this.description,
      this.category,
      this.rating});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        price: (json['price'] ?? 0.0).toDouble(),
        description: json['description'] ?? '',
        category: json['category'] ?? '',
        image: json['image'] ?? '',
        rating: (json['rating']['rate'] ?? 0.0).toDouble());
  }
}
