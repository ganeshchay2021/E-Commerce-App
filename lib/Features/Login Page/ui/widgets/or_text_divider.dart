import 'package:flutter/material.dart';

class OrTextDivider extends StatelessWidget {
  const OrTextDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey.shade300,
              thickness: 2,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Or",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey.shade300,
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
