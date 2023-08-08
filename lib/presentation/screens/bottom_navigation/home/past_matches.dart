import 'package:flutter/material.dart';

class PastMatchesScreen extends StatelessWidget {
  const PastMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          'Past Matches Tab',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32),
        ));
  }
}
