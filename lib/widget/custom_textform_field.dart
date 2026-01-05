import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  CustomTextformfield({
    super.key,
    this.labelText,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.child,
    this.isPassword = false,
    this.title,
    this.height,
    this.width,
    this.hintText,
    this.maxLines,
    this.initialValue,
  });

  String? labelText;
  String? initialValue;
  String? hintText;
  int? maxLines;
  TextInputType? keyboardType;
  Widget? suffixIcon, prefixIcon;
  String? Function(String?)? validator;
  Function(String)? onChanged;
  bool? obscureText;
  Widget? child;
  bool isPassword;
  Widget? title;

  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 55,
      width: width ?? double.infinity,
      child: TextFormField(
        keyboardType: keyboardType ?? TextInputType.text,
        initialValue: initialValue, // <-- Add this line
        maxLines: maxLines ?? 1,     // <-- Ensure maxLines is applied
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onChanged: onChanged,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
