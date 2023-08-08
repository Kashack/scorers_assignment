import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:scorers_assignment/business/bloc/profile/profile_bloc.dart';
import 'package:scorers_assignment/presentation/argurment/update_profile_data.dart';
import 'package:scorers_assignment/presentation/routers/router_constant.dart';

import '../../../../business/bloc/authentication/authentication_bloc.dart';
import '../../../components/custom_button.dart';
import '../../../components/view_profile_tile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile_background.png'),
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
                                'View Profile',
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
                    'Your profile is shown here',
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
            child: BlocConsumer<ProfileBloc, ProfileState>(
              buildWhen: (previous, current) {
                return current is ProfileSuccess || current is ProfileError;
              },
              builder: (context, userState) {
                final token = context
                    .select((AuthenticationBloc state) => state.state.token);
                if (userState is ProfileSuccess) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ViewProfileTile(
                            title: 'First Name',
                            subtitle: userState.userDetailModel.firstName),
                        ViewProfileTile(
                            title: 'Last Name',
                            subtitle: userState.userDetailModel.lastName),
                        ViewProfileTile(
                            title: 'Username',
                            subtitle: userState.userDetailModel.username),
                        ViewProfileTile(
                          title: 'Gender',
                          subtitle: userState.userDetailModel.gender ?? '',
                        ),
                        ViewProfileTile(
                          title: 'Date of Birth',
                          subtitle: userState.userDetailModel.DOB ?? '',
                        ),
                        ViewProfileTile(
                          title: 'Age',
                          subtitle: userState.userDetailModel.age == null
                              ? ''
                              : userState.userDetailModel.age.toString(),
                        ),
                        ViewProfileTile(
                          title: 'Nationality',
                          subtitle: userState.userDetailModel.nationality ?? '',
                        ),
                        ViewProfileTile(
                          title: 'email',
                          subtitle: userState.userDetailModel.email,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomButton(
                            title: 'Update Profile',
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouterConstant.ProfileUpdate,
                                  arguments: UpdateProfileData(
                                      userDetail: userState.userDetailModel));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (userState is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Center(
                  child: TextButton(
                    onPressed: () {
                      context
                          .read<ProfileBloc>()
                          .add(UserDetailRequested(token: token));
                    },
                    child: const Text('Retry'),
                  ),
                );
              },
              listener: (context, state) async {
                if (state is ProfileError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage)));
                  if (state.errorMessage ==
                      "Auth token has expired, please login again") {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested());
                    await AuthenticationBloc().clear().then((value) async {
                      await HydratedBloc.storage.close().then((value) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, RouterConstant.HomePage, (route) => false);
                      });
                    });
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
