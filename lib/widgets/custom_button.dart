import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.color,
    required this.circularCorners,
    required this.text,
    required this.fontSize,
    required this.onPressed,
  }) : super(key: key);
  final Color color;
  final double circularCorners;
  final String text;
  final double fontSize;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(circularCorners),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
