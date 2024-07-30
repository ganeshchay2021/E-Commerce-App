import 'package:myecomapp/Features/Cat%20Page/model/cart_model.dart';

class OrderProductModel {
  final String id;
  final List<CartModel> orderItems;
  final String fullName;
  final String address;
  final String city;
  final String phone;
  final String status;
  final int totalPrice;
  final String code;
  final DateTime dateOrdered;
  final int quantity;

  OrderProductModel({
    required this.id,
    required this.orderItems,
    required this.fullName,
    required this.address,
    required this.city,
    required this.phone,
    required this.status,
    required this.totalPrice,
    required this.code,
    required this.dateOrdered,
    required this.quantity,
  });

  factory OrderProductModel.fromMap(Map<String, dynamic> map) {
    return OrderProductModel(
        id: map["_id"],
        orderItems: List.from(map["orderItems"])
            .map((e) => CartModel.fromMap(e))
            .toList(),
        fullName: map["full_name"],
        address: map["address"],
        city: map["city"],
        phone: map["phone"],
        status: map["status"],
        totalPrice: map["totalPrice"],
        code: map["code"],
        dateOrdered: DateTime.parse(map["dateOrdered"]),
        quantity: map["quantity"]);
  }
}
