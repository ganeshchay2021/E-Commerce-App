// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class ProductReview extends StatelessWidget {
  final String brand;
  final String category;

  const ProductReview({
    super.key,
    required this.brand,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text(
              "Rating",
              style: TextStyle(fontSize: 20),
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black),
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.star,
                      color: Theme.of(context)
                          .primaryColor,
                    ),
                  ),
                  const TextSpan(text: " 4.2")
                ],
              ),
            ),
          ],
        ),
        const Column(
          children: [
            Text(
              "Brand",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Apple",
              style: TextStyle(
                  fontSize: 20, color: Colors.grey),
            )
          ],
        ),
        const Column(
          children: [
            Text(
              "Category",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Phone",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ],
    );
  }
}
