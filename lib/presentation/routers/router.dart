import 'package:flutter/material.dart';
import 'package:scorers_assignment/presentation/routers/router_constant.dart';
import 'package:scorers_assignment/presentation/screens/authentication/log_in.dart';
import 'package:scorers_assignment/presentation/screens/authentication/sign_up.dart';
import 'package:scorers_assignment/presentation/screens/bottom_navigation/home/home_nav.dart';
import 'package:scorers_assignment/presentation/screens/home_screen.dart';
import 'package:scorers_assignment/presentation/screens/menu_screens/profile/profile.dart';
import 'package:scorers_assignment/presentation/screens/menu_screens/profile/update_profile.dart';

class AppRouter{
  static Route onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case RouterConstant.HomeNav:
        return  MaterialPageRoute(
          builder: (_) => HomeNavigation(),
          settings: settings,
        );
      case RouterConstant.HomePage:
        return  MaterialPageRoute(
          builder: (_) => HomeScreen(),
          settings: settings,
        );
      case RouterConstant.SignUp:
        return  MaterialPageRoute(
          builder: (_) => SignUpScreen(),
          settings: settings,
        );
      case RouterConstant.LogIn:
        return  MaterialPageRoute(
          builder: (_) => LogInScreen(),
          settings: settings,
        );
      case RouterConstant.Profile:
        return  MaterialPageRoute(
          builder: (_) => Profile(),
          settings: settings,
        );
      case RouterConstant.ProfileUpdate:
        return  MaterialPageRoute(
          builder: (_) => UpdateProfile(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Error: Route not found!'),
            ),
          ),
        );
    }
  }
}