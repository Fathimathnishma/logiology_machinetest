import 'package:flutter/material.dart';

class CTextFormField extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final double? borderRadius;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;

  const CTextFormField({
    super.key,
    this.height,
    this.width,
    this.color,
    this.borderRadius,
    this.labelText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ), // Set label text color to black
          filled: color != null,
          fillColor: color,
          // Adjusting border with a thinner black border
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.0,
            ), // thinner border
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
          // Focused border with black color as well
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
          // Disabled border also set to black
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
        ),
      ),
    );
  }
}
