import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final suffixIcon;
  final onTap;

  IconData? icon;
  final bool obscureText;
  final VoidCallback? onSuffixIconPressed;
  final validator;
  final keyboardType;

  CustomTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.icon,
    this.suffixIcon,
    this.obscureText = false,
    this.onSuffixIconPressed,
  this.validator,
    this.onTap,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.brown,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onTap: onTap,
keyboardType:keyboardType ,

      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.brown.shade200, width: 1.6),
            borderRadius: BorderRadius.circular(32)),
        prefixIcon: icon != null
            ? IconButton(
                icon: Icon(icon),
                onPressed: () {},
                color: Colors.brown,
              )
            : null,
        hintText: hintText,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: suffixIcon!,
                onPressed: onSuffixIconPressed,
              )
            : null,

        // suffixIcon: icon != null?IconButton(icon: Icon(icon) ,):null,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: Colors.brown.shade500, width: 1.6)),
      ),
    );
  }
}
