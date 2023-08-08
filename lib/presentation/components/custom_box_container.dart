import 'package:flutter/material.dart';

class CustomBoxContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  const CustomBoxContainer({required this.child, this.padding, this.margin,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0x99FFFFFF)),
          gradient: LinearGradient(
            colors: [
              Color(0x29020000),
              Color(0x11FFFFFF),
              Color(0x99FFFFFF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 1, 0.1],
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 40,
                offset: Offset(0, 20),
                color: Color(0x26000000)),
          ],
          borderRadius: BorderRadius.circular(15)),
      child: child,
    );
  }
}
