import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool isObscure;
  final bool? enabled;
  final bool autofocus;
  final TextInputAction? textInputAction;

  final bool? readOnly;
  final TextEditingController textController;
  final String? hintText;
  final String? labelText;

  // To prevent layout shifts, provide a helperText value (even empty string "") as recommended in the Flutter documentation.
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;

  const CustomTextField({
    super.key,
    this.isObscure = false,
    this.enabled,
    this.autofocus = false,
    this.textInputAction,

    this.readOnly = false,
    required this.textController,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.keyboardType,
    this.autofillHints,
    this.autovalidateMode,
    this.hintText,
    this.labelText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      enabled: enabled,
      autofocus: autofocus,
      textInputAction: textInputAction,
      style: TextStyle(color: Colors.white),
      readOnly: readOnly ?? false,
      validator: validator,
      onChanged: onChanged,
      autofillHints: autofillHints,
      autovalidateMode: autovalidateMode,
      keyboardType: keyboardType,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText ?? hintText,

        errorMaxLines: 20,

        helperText: helperText,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
