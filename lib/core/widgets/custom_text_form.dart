import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool obscureText;
  final TextEditingController? controller;
  final int? maxLines;
  final VoidCallback? onTogglePasswordVisibility;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isPassword = false,
    this.obscureText = false,
    this.controller,
    this.onTogglePasswordVisibility, this.maxLines=1, this.suffixIcon, this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        border: outlineBorder,
        enabledBorder: outlineBorder,
        focusedBorder: outlineBorder,
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: onTogglePasswordVisibility,
                )
                : suffixIcon,
      ),
    );
  }
}
