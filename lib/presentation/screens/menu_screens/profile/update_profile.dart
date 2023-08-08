import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:scorers_assignment/business/bloc/profile/profile_bloc.dart';
import 'package:scorers_assignment/logic/model/user.dart';
import 'package:scorers_assignment/presentation/argurment/update_profile_data.dart';
import 'package:scorers_assignment/presentation/routers/router_constant.dart';

import '../../../../business/bloc/authentication/authentication_bloc.dart';
import '../../../components/custom_button.dart';
import '../../../components/update_profile_tile.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController usernameController;
  late TextEditingController genderController;
  late TextEditingController ageController;
  late TextEditingController emailController;
  late TextEditingController DOBController;
  late TextEditingController nationalityController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    usernameController = TextEditingController();
    genderController = TextEditingController();
    ageController = TextEditingController();
    emailController = TextEditingController();
    DOBController = TextEditingController();
    nationalityController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    genderController.dispose();
    ageController.dispose();
    emailController.dispose();
    DOBController.dispose();
    nationalityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UpdateProfileData;
    firstNameController.text = args.userDetail.firstName;
    lastNameController.text = args.userDetail.lastName;
    usernameController.text = args.userDetail.username;
    ageController.text = args.userDetail.age == null ? '' : args.userDetail.age.toString();
    emailController.text = args.userDetail.email;
    DOBController.text = args.userDetail.DOB ?? '';
    nationalityController.text = args.userDetail.nationality ?? '';
    genderController.text = args.userDetail.gender ?? '';
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) async {
                if (state is ProfileUpdateError) {
                  if (state.errorMessage == "Auth token has expired, please login again") {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested());
                    await AuthenticationBloc()
                        .clear()
                        .then((value) async {
                      await HydratedBloc.storage
                          .close()
                          .then((value) {
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouterConstant.HomePage,
                            (route) => false);
                      });
                    });
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                }
                else if (state is ProfileSuccess) {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20))),
                    backgroundColor: Colors.white,
                    builder: (context) {
                      return Column(
                        children: [
                          Container(
                            height: 5,
                            width: 50,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: const Color(0x4079747E),
                                borderRadius:
                                    BorderRadius.circular(10)),
                          ),
                          Image.asset('assets/images/done_icon.png'),
                          const Text(
                            'It\'s done!',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 60.0, vertical: 8),
                            child: Text(
                              'Your profile has been successfully updated.',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CustomButton(
                              title: 'Done',
                              onPressed: () {
                                Navigator.popUntil(
                                    context,
                                    ModalRoute.withName(
                                        RouterConstant.Profile));
                              },
                            ),
                          )
                        ],
                      );
                    },
                  );
                }
        },
        builder: (context, state) {
          final token = context.select((AuthenticationBloc state) => state.state.token);
          return Stack(
            children: [
              Form(
                key: _globalKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/profile_background.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
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
                                  const Expanded(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Update Profile',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 22,
                                              color: Colors.white),
                                        )),
                                  )
                                ],
                              ),
                            ),
                            const Text(
                              'Modify your profile from here',
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              UpdateProfileTile(
                                  title: 'First Name',
                                  controller: firstNameController
                              ),
                              UpdateProfileTile(
                                  title: 'Last Name',
                                  controller: lastNameController,),
                              UpdateProfileTile(
                                  title: 'Username',
                                  controller: usernameController,),
                              UpdateProfileTile(
                                title: 'Gender',
                                controller: genderController,
                              ),
                              UpdateProfileTile(
                                title: 'Date of Birth',
                                controller: DOBController,
                                textInputType: TextInputType.datetime,
                              ),
                              UpdateProfileTile(
                                title: 'Age',
                                controller: ageController,
                                textInputType: TextInputType.number,
                              ),
                              UpdateProfileTile(
                                title: 'email',
                                controller: emailController,
                                textInputType: TextInputType.emailAddress,
                              ),
                              UpdateProfileTile(
                                title: 'Nationality',
                                controller: nationalityController,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0),
                                child: CustomButton(
                                  title: 'Update Profile',
                                  onPressed: () {
                                    if(_globalKey.currentState!.validate()){
                                      context
                                          .read<ProfileBloc>()
                                          .add(UpdateUserDetailRequested(
                                          token: token,
                                          user: UserDetail(
                                            firstName: firstNameController.text,
                                            lastName: lastNameController.text,
                                            email: emailController.text,
                                            username: usernameController.text,
                                            age: int.tryParse(ageController.text),
                                            DOB: DOBController.text,
                                            gender: genderController.text,
                                            nationality: nationalityController.text,
                                          )));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (state is ProfileUpdateLoading)
                const Opacity(
                  opacity: 0.8,
                  child: ModalBarrier(
                    dismissible: false,
                    color: Colors.black12,
                  ),
                ),
              if (state is ProfileUpdateLoading)
                const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 3,
                ))
            ],
          );
        },
      ),
    );
  }
}
