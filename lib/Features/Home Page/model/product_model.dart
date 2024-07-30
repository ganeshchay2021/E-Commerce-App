// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String id;
  final String name;
  final String description;
  final String image;
  final String brand;
  final int price;
  final List<String> catagories;
  final bool addToCart;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.brand,
    required this.price,
    required this.catagories,
    required this.addToCart,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map["_id"],
      name: map["name"],
      description: map["description"] ?? "",
      image: map["image"] ??
          "https://crwd-live.s3.eu-central-1.amazonaws.com/static/images/static-images/Image_not_available.png",
      brand: map["brand"],
      price: map["price"],
      catagories:
          List.from((map["catagories"])).map((e) => e.toString()).toList(),
      addToCart: map["added_in_cart"] ?? false,
    );
  }
}
