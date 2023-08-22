import 'package:flutter/material.dart';

class MyInputText extends StatelessWidget {
  const MyInputText({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.autofocus = false,
    this.validator,
    this.decoration = const InputDecoration(),
    this.labelText,
    this.filled = true,
    this.suffixIcon,
    this.prefixIcon,
    required this.text,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
  });

  final TextEditingController? controller;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final bool autofocus;
  final String? Function(String?)? validator;
  final InputDecoration? decoration;
  final String? labelText;
  final bool filled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String text;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      autocorrect: autocorrect,
      autofocus: autofocus,
      enableSuggestions: enableSuggestions,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        suffixIcon: suffixIcon,
        hintText: text,
        filled: filled,
        isDense: true,
      ),
    );
  }
}
