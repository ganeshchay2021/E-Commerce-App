import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myecomapp/Features/Login%20Page/ui/pages/login_screen.dart';
import 'package:page_transition/page_transition.dart';

class LoginTextButton extends StatelessWidget {
  const LoginTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          text: "Already have an account?  ",
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: "Login",
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: const LoginScreen(),
                        type: PageTransitionType.fade),
                  );
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
      ),
    );
  }
}
