import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scorers_assignment/business/bloc/authentication/authentication_bloc.dart';
import 'package:scorers_assignment/presentation/components/custom_button.dart';
import 'package:scorers_assignment/presentation/routers/router_constant.dart';

import '../../components/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? first_name;
  String? last_name;
  String? username;
  String? email;
  String? password;
  String? repeat_password;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if(state is UnAuthenticatedState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
            if(state is AuthenticatedState){
              Navigator.pushNamedAndRemoveUntil(context, RouterConstant.HomePage, (route) => false);
            }
          },
          child: Builder(builder: (context) {
            final authState = context
                .select((AuthenticationBloc state) => state.state.status);
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/background_auth.png'),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40))),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  child: const Icon(
                                    Icons.chevron_left,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Expanded(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        'assets/images/app_logo.png',
                                        height: 80,
                                        width: 80,
                                      )),
                                )
                              ],
                            ),
                            const Text(
                              'Create\nAccount.',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 28),
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CustomTextField(
                                label: 'First Name',
                                validator: (validator) {
                                  if (validator!.isEmpty) {
                                    return 'Enter your First Name';
                                  }
                                  return null;
                                },
                                onChanged: (value) => first_name = value,
                              ),
                              CustomTextField(
                                label: 'Last Name',
                                validator: (validator) {
                                  if (validator!.isEmpty) {
                                    return 'Enter your Last Name';
                                  }
                                  return null;
                                },
                                onChanged: (value) => last_name = value,
                              ),
                              CustomTextField(
                                label: 'Username',
                                validator: (validator) {
                                  if (validator!.isEmpty) {
                                    return 'Enter your UserName';
                                  }
                                  return null;
                                },
                                onChanged: (value) => username = value,
                              ),
                              CustomTextField(
                                label: 'Email Address',
                                validator: (validator) {
                                  if (validator!.isEmpty) {
                                    return 'Enter your Email Address';
                                  }
                                  return null;
                                },
                                onChanged: (value) => email = value,
                              ),
                              CustomTextField(
                                label: 'Password',
                                validator: (validator) {
                                  if (validator!.isEmpty) {
                                    return 'Enter your Password';
                                  }
                                  return null;
                                },
                                isObscureText: true,
                                onChanged: (value) => password = value,
                              ),
                              CustomTextField(
                                label: 'Confirm New Password',
                                validator: (validator) {
                                  if (validator!.isEmpty) {
                                    return 'Re-Enter your Password';
                                  } else if (validator != password) {
                                    return 'Enter the correct password';
                                  }
                                  return null;
                                },
                                isObscureText: true,
                                onChanged: (value) => repeat_password = value,
                              ),
                              CustomButton(title: 'Sign Up', onPressed: () {
                                if (_globalKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  context.read<AuthenticationBloc>().add(
                                    AuthenticationSignUpRequested(
                                      first_name: first_name!,
                                      last_name: last_name!,
                                      username: username!,
                                      email: email!,
                                      password: password!,
                                      repeat_password: repeat_password!,
                                    ),
                                  );
                                }
                              },),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (authState == AuthenticationStatus.loading)
                  const Opacity(
                    opacity: 0.8,
                    child: ModalBarrier(
                      dismissible: false,
                      color: Colors.black12,
                    ),
                  ),
                if (authState == AuthenticationStatus.loading)
                  const Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ))
              ],
            );
          }),
        ),
      ),
    );
  }
}
