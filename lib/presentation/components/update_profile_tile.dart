import 'package:flutter/material.dart';

class UpdateProfileTile extends StatelessWidget {
  final String title;
  final Function(String?)? validator;
  final Widget? suffix_icon;
  final TextInputType textInputType;
  final TextEditingController controller;

  UpdateProfileTile(
      {required this.title,
      this.validator,
      this.suffix_icon, this.textInputType = TextInputType.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Fill the Field';
            }
            return null;
          },
          keyboardType: textInputType,
          decoration: InputDecoration(
            suffixIcon: suffix_icon,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
