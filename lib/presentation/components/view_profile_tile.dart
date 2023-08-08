import 'package:flutter/material.dart';

import '../../utility/constant.dart';

class ViewProfileTile extends StatelessWidget {
  final String title;
  final String subtitle;


  ViewProfileTile({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 20,
                offset: Offset(2, 8),
                color: Color(0x33B5B5B5)
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(title,style: TextStyle(color: gray3,fontWeight: FontWeight.w500,fontSize: 11)),
          ),
          Text(subtitle,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black)),
        ],
      ),
    );
  }
}