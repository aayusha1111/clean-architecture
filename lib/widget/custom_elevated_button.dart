import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.child,
    this.foregroundColor,
    this.onPressed,
  });

  final double? borderRadius;
  final Widget? child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(0, 55)), // just height
        backgroundColor:
            MaterialStateProperty.all(backgroundColor ?? Colors.green),
        foregroundColor:
            MaterialStateProperty.all(foregroundColor ?? Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Center(child: child),
    );
  }
}
