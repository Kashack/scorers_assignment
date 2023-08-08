import 'package:flutter/material.dart';

import '../../utility/constant.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;

  CustomButton({required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      minWidth: double.infinity,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: secondaryColor,
    );
  }
}