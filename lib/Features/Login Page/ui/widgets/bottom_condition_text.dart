import 'package:flutter/material.dart';

class BottomConditionText extends StatelessWidget {
  const BottomConditionText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text:
                  "By connecting your account confirm that you agree with our ",
              style: const TextStyle(
                height: 1.5,
                color: Colors.grey,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: "Term and Condition",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
