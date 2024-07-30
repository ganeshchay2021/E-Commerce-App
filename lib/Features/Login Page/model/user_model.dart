class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["_id"],
      name: map["name"],
      email: map["email"],
      phone: map["phone"],
      address: map["address"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
    };
  }
}
