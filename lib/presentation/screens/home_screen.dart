import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorers_assignment/presentation/screens/bottom_navigation/home/home_nav.dart';
import 'package:scorers_assignment/presentation/screens/menu_screens/menu_drawer.dart';
import 'package:scorers_assignment/utility/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bottomNavigationList[_selectindex]['Name'],
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const MenuDrawer(),
      body: bottomNavigationList[_selectindex]['Navigation'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w500, color: primaryColor),
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectindex,
        onTap: (value) => setState(() {
          _selectindex = value;
        }),
        items: bottomNavigationList
            .map(
              (item) => BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    item['icon'],
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                  activeIcon: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: SvgPicture.asset(item['icon'],
                        colorFilter:
                            const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                  ),
                  label: item['Name']),
            )
            .toList(),
      ),
    );
  }
}

const List<Map<String, dynamic>> bottomNavigationList = [
  {
    'Name': 'Home',
    'icon': 'assets/icons/home.svg',
    'Navigation' : HomeNavigation(),
  },
  {
    'Name': 'Predict',
    'icon': 'assets/icons/chart_bar.svg',
  },
  {
    'Name': 'Leaderboard',
    'icon': 'assets/icons/flag.svg',
  },
  {
    'Name': 'Reward',
    'icon': 'assets/icons/gift.svg',
  },
  {
    'Name': 'Highlights',
    'icon': 'assets/icons/ball.svg',
  },
];
