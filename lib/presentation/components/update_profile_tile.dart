import 'package:flutter/material.dart';

class UpdateProfileTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Function(String?)? validator;
  final Function(String) onChanged;
  final Widget? suffix_icon;

  UpdateProfileTile(
      {required this.title,
      required this.subtitle,
      this.validator,
      required this.onChanged,
      this.suffix_icon});

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
          initialValue: subtitle,
          onChanged: onChanged,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Fill the Field';
            }
            return null;
          },
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
