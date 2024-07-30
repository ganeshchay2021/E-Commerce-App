import 'package:myecomapp/Features/Home%20Page/model/product_model.dart';

class CartModel {
  final String id;
  final int quantity;
  final Product product;
  CartModel({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
        id: map["_id"],
        quantity: map["quantity"],
        product: Product.fromMap(map["product"]));
  }
}
