// ignore_for_file: public_member_api_docs, sort_constructors_first
class CheckoutModel {
  final String name;
  final String address;
  final String city;
  final String phoneNumber;
  CheckoutModel({
    required this.name,
    required this.address,
    required this.city,
    required this.phoneNumber,
  });

  factory CheckoutModel.fromMap(Map<String, dynamic> map) {
    return CheckoutModel(
        name: map["Name"],
        address: map["Address"],
        city: map["City"],
        phoneNumber: map["Phone number"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "address": address,
      "city": city,
      "phone": phoneNumber,
      "full_name": name
    };
  }
}
