class Product {
  final int id;
  final String name;
  final String imagePath;
  final int price;
  final int userId;

  Product({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.userId
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id : json["id"],
      userId: json['userId'],
      name: json['name'],
      imagePath: json['imagePath'],
      price: json['price'],
    );
  }
}