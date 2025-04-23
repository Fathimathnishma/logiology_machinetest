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
  final Function(String)? onChanged; // Add onChanged callback

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
    this.onChanged, // Initialize onChanged
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
        onChanged: onChanged, // Trigger onChanged when text changes
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black, fontSize: 15),
          filled: color != null,
          fillColor: color,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
        ),
      ),
    );
  }
}
