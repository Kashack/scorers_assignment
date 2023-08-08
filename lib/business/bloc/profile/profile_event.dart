part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class UserDetailRequested extends ProfileEvent{
  final String token;

  UserDetailRequested({required this.token});
}

class UpdateUserDetailRequested extends ProfileEvent{
  final String token;
  final UserDetail user;

  UpdateUserDetailRequested({required this.token,required this.user});
}