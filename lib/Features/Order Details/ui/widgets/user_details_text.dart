// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
class MyRichText extends StatelessWidget {
  final String title;
  final String text;

  const MyRichText({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(text: title),
            TextSpan(
              text: text,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            )
          ]),
    );
  }
}
