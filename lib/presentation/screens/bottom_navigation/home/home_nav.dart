import 'package:flutter/material.dart';
import 'package:scorers_assignment/presentation/screens/bottom_navigation/home/live_matches.dart';
import 'package:scorers_assignment/presentation/screens/bottom_navigation/home/past_matches.dart';
import 'package:scorers_assignment/utility/constant.dart';

import 'new_matches.dart';

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF008F8F),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      offset: Offset(2, 8),
                      color: Color(0x33B5B5B5)
                    )
                  ]
                ),
                child: const TabBar(
                  labelColor: Colors.black,
                  indicator: BoxDecoration(
                    color: Colors.white,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: gray5,
                  labelStyle: TextStyle(fontWeight: FontWeight.w500),
                  tabs: [
                    Tab(
                      text: 'Live Matches',
                    ),
                    Tab(
                      text: 'New Matches',
                    ),
                    Tab(
                      text: 'Past Matches',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LiveMatchesScreen(),
            NewMatchesScreen(),
            PastMatchesScreen(),
          ],
        ),
      ),
    );
  }
}
