import 'package:flutter/material.dart';

class NewMatchesScreen extends StatelessWidget {
  const NewMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'New Matches Tab',
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32),
    ));
  }
}
