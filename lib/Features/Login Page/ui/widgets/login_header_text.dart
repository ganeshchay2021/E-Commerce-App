
import 'package:flutter/material.dart';

class LoginHeaderText extends StatelessWidget {
  const LoginHeaderText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Welcome Back",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            height: 1.2,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Enter your credential to login",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade400,
            height: 1.2,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
