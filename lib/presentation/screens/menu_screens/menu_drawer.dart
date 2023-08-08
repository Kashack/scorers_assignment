import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:scorers_assignment/presentation/components/custom_box_container.dart';
import 'package:scorers_assignment/presentation/routers/router_constant.dart';

import '../../../business/bloc/authentication/authentication_bloc.dart';
import '../../../business/bloc/profile/profile_bloc.dart';
import '../../../utility/constant.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      child: Builder(
        builder: (context) {
          final authState = context.select((AuthenticationBloc state) => state.state.status);
          final token = context.select((AuthenticationBloc state) => state.state.token);
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/app_logo.png',
                    width: 70,
                    height: 70,
                  ),
                  Expanded(
                    child: CustomBoxContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Visibility(
                            visible: authState == AuthenticationStatus.authenticated ? true: false,
                            child: GestureDetector(
                              onTap: () {
                                context.read<ProfileBloc>().add(UserDetailRequested(token: token));
                                Navigator.pushNamed(context, RouterConstant.Profile);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.account_circle_outlined),
                                    SizedBox(width: 10,),
                                    Text('Update Profile')
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: authState == AuthenticationStatus.authenticated ? false: true,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouterConstant.SignUp);
                      },
                      child: CustomBoxContainer(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/sign_up.svg'),
                            const SizedBox(width: 8,),
                            const Text('Sign Up',style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: authState == AuthenticationStatus.authenticated ? false: true,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouterConstant.LogIn);
                      },
                      child: CustomBoxContainer(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/login.svg'),
                            const SizedBox(width: 8,),
                            const Text('Login',style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: authState == AuthenticationStatus.authenticated ? true: false,
                    child: GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                title: const Column(
                                  children: [
                                    Divider(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Log out',
                                      style: TextStyle(
                                          fontWeight: FontWeight
                                              .w500),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20)),
                                content: const Text(
                                    'Are you sure you want to log out',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  MaterialButton(
                                    onPressed: () async {
                                      context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
                                      await AuthenticationBloc().clear().then((value) async {
                                        await HydratedBloc.storage.close().then((value){
                                          Navigator.pop(context);
                                        });
                                      });
                                    },
                                    color: primaryColor,
                                    child: const Text(
                                      'Logout',
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                                alignment: Alignment.center,
                                actionsAlignment: MainAxisAlignment
                                    .center,
                              ),
                        );
                      },
                      child: CustomBoxContainer(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/logout.svg'),
                            const SizedBox(width: 8,),
                            const Text('Logout',style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
