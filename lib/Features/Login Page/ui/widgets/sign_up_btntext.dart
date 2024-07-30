// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myecomapp/Features/Sign%20Up%20Page/ui/pages/sign_up_screen.dart';
import 'package:page_transition/page_transition.dart';

class SignUpButtonText extends StatelessWidget {
  const SignUpButtonText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Don't have Account?  ",
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        children: [
          TextSpan(
            text: "Sign Up",
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const SignUpScreen(),
                        type: PageTransitionType.fade));
              },
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
