import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

ToastFuture toastMsg(BuildContext context, String tostMsg, Color color) {
  return showToast(
    textStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: color,
    tostMsg,
    context: context,
    animation: StyledToastAnimation.scale,
  );
}
