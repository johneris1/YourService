import 'package:flutter/material.dart';

void LoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white.withOpacity(0.85),
    builder: (context) {
      return AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Material(
          type: MaterialType.transparency,
          child: Image.asset(
            "assets/images/load.gif",
            height: 150,
            width: 150,
          ),
        ),
      );
    },
  );
}
