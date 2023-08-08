import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final Widget? suffixIcon;
  final Function()? onEditingComplete;
  final Iterable<String>? autofillHints;
  final TextInputType? inputType;
  final bool isObscureText;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    this.suffixIcon,
    this.onEditingComplete,
    this.autofillHints,
    this.validator,
    this.isObscureText = false,
    this.inputType = TextInputType.text,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: inputType,
        validator: validator,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        autofillHints: autofillHints,
        obscureText: isObscureText,
        decoration: InputDecoration(
          label: Text(label),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
