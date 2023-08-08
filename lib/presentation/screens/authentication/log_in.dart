import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scorers_assignment/presentation/components/custom_button.dart';
import 'package:scorers_assignment/presentation/routers/router_constant.dart';

import '../../../business/bloc/authentication/authentication_bloc.dart';
import '../../../utility/constant.dart';
import '../../components/custom_text_field.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  String? email;
  String? password;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool rememberPassword = false;

  bool _isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if(state is UnAuthenticatedState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
          if(state is AuthenticatedState){
            Navigator.pushNamedAndRemoveUntil(context, RouterConstant.HomePage, (route) => false);
          }
        },
        child: Builder(builder: (context) {
          final authState =
              context.select((AuthenticationBloc state) => state.state.status);
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
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(40))),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                ),
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
                            'Welcome\nBack!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 24),
                          ),
                          const Text(
                            'Continue to enjoying the prediction',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _globalKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomTextField(
                              label: 'Email Address',
                              autofillHints: const [AutofillHints.email],
                              validator: (validator) {
                                if (validator!.isEmpty) {
                                  return 'Enter your Email Address';
                                }
                                return null;
                              },
                              inputType: TextInputType.emailAddress,
                              onChanged: (value) => email = value,
                            ),
                            CustomTextField(
                              label: 'Password',
                              autofillHints: const [AutofillHints.password],
                              validator: (validator) {
                                if (validator!.isEmpty) {
                                  return 'Enter your Password';
                                }
                                return null;
                              },
                              isObscureText: _isObsecure,
                              suffixIcon: _isObsecure == true
                                  ? IconButton(
                                      icon: const Icon(Icons.visibility_off_outlined),
                                      onPressed: () => setState(
                                          () => _isObsecure = !_isObsecure),
                                    )
                                  : IconButton(
                                      onPressed: () => setState(
                                          () => _isObsecure = !_isObsecure),
                                      icon: const Icon(Icons.visibility_outlined)),
                              onChanged: (value) => password = value,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: rememberPassword,
                                        onChanged: (value) {
                                          setState(() {
                                            rememberPassword = value!;
                                          });
                                        },
                                      ),
                                    ),

                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        'Remember me',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF595956),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Forget Password?',
                                      style: TextStyle(color: gray3),
                                    ))
                              ],
                            ),
                            CustomButton(title: 'Login',onPressed: () {
                              if (_globalKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                if(rememberPassword == true){
                                  TextInput.finishAutofillContext();
                                }
                                context.read<AuthenticationBloc>().add(
                                  AuthenticationSignInRequested(
                                    email: email!,
                                    password: password!,
                                  ),
                                );
                              }
                            },),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don’t have an account? ',style: TextStyle(fontWeight: FontWeight.w500),),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouterConstant.SignUp);
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                  )
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
    );
  }
}
