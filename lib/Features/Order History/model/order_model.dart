class OrderModel {
  final String id;
  final String status;
  final int totalPrice;
  final String code;
  final DateTime dateOrdered;
  final int quantity;

  OrderModel({
    required this.id,
    required this.status,
    required this.totalPrice,
    required this.code,
    required this.dateOrdered,
    required this.quantity,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
        id: map["_id"],
        status: map["status"],
        totalPrice: map["totalPrice"],
        code: map["code"],
        dateOrdered: DateTime.parse(map["dateOrdered"]?? DateTime.now()),
        quantity: map["quantity"]);
  }
}
