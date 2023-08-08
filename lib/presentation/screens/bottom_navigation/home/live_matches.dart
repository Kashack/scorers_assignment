import 'package:flutter/material.dart';

class LiveMatchesScreen extends StatelessWidget {
  const LiveMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          'Live Matches Tab',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32),
        ))
    ;
  }
}
