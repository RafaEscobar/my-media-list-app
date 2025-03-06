import 'package:flutter/material.dart';

class TapWidget extends StatelessWidget {
  const TapWidget({
    super.key,
    this.width = 200,
    this.borderRadius,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
    this.splashColor,
    required this.onTap,
    required this.body,
  });
  final BorderRadius? borderRadius;
  final Color? splashColor;
  final double width;
  final Color backgroundColor;
  final Function() onTap;
  final Widget body;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
      child: Material(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        child: InkWell(
          splashColor: splashColor ?? Colors.blue.shade50,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: body,
          )
        ),
      ),
    );
  }
}