import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scorers_assignment/logic/api/user_detail_repository.dart';
import 'package:scorers_assignment/logic/custom_exception.dart';
import 'package:scorers_assignment/logic/model/user.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserDetailRepository repository = UserDetailRepository();

  ProfileBloc() : super(ProfileInitial()) {
    on<UserDetailRequested>(_UserDetailRequested);
    on<UpdateUserDetailRequested>(_UpdateUserDetailRequested);
  }

  FutureOr<void> _UserDetailRequested(UserDetailRequested event,
      Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await repository.GetUserProfile(authorizationToken: event.token).then((
          value) {
        emit(ProfileSuccess(value));
      });
    } catch (e) {
      if (e is SocketException) {
        emit(ProfileError(e.message));
      } else if (e is UserDetailException) {
        emit(ProfileError(e.message));
      } else {
        emit(ProfileError(e.toString()));
      }
    }
  }

  Future<FutureOr<void>> _UpdateUserDetailRequested(UpdateUserDetailRequested event,
      Emitter<ProfileState> emit) async {
    emit(ProfileUpdateLoading());
    try {
      await repository.UpdateUserProfile(authorizationToken: event.token, userDetail: event.user).then((
          value) {
        emit(ProfileSuccess(value));
      });
    } catch (e) {
      if (e is SocketException) {
        emit(ProfileUpdateError(e.message));
      } else if (e is UserDetailException) {
        emit(ProfileUpdateError(e.message));
      } else {
        emit(ProfileUpdateError(e.toString()));
      }
    }
  }
}
