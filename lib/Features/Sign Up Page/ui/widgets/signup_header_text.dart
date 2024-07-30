import 'package:flutter/material.dart';

class SignUpHeaderText extends StatelessWidget {
  const SignUpHeaderText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Create your account here !",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 26,
              height: 1.2),
        ),
        Text(
          "Create account and we will continue",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
