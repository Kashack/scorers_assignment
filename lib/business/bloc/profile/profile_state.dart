part of 'profile_bloc.dart';

@immutable
abstract class ProfileState{

  // @override
  // List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}
class ProfileUpdate extends ProfileState {}

class ProfileSuccess extends ProfileState{
  final UserDetail userDetailModel;

  ProfileSuccess(this.userDetailModel);
}

class ProfileLoading extends ProfileState{

}
class ProfileUpdateLoading extends ProfileUpdate{

}

class ProfileError extends ProfileState{
  final String errorMessage;

  ProfileError(this.errorMessage);

}

class ProfileUpdateError extends ProfileUpdate{
  final String errorMessage;

  ProfileUpdateError(this.errorMessage);
}