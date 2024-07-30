// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:myecomapp/Features/Order%20Details/model/order_product_model.dart';
import 'package:myecomapp/Features/Order%20Details/ui/widgets/user_details_text.dart';

class UserDetailBox extends StatelessWidget {
  final OrderProductModel orderDetail;
  const UserDetailBox({
    super.key,
    required this.orderDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(18)),
        width: double.infinity,
        height: 80,
        child: Row(
          children: [
            Image.asset(
              "assets/images/profile.png",
              height: 50,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyRichText(
                    title: "Name: ",
                    text: orderDetail.fullName,
                  ),
                  MyRichText(
                    title: "Address: ",
                    text: orderDetail.address,
                  ),
                  MyRichText(
                    title: "Phone Number: ",
                    text: orderDetail.phone,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
