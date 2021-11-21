import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onTapped;
  final Color color;
  final double buttonWidth;
  final String title;
  final bool isPersonalized = false;
  final childWidget;

  CustomButton(
      {@required this.onTapped,
      this.color,
      @required this.buttonWidth,
      this.title,
      this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: onTapped,
        child: Container(
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          width: buttonWidth,
          padding: EdgeInsets.symmetric(vertical: 18),
          child: isPersonalized
              ? childWidget
              : Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}
