import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:scorers_assignment/logic/api/authentication_repository.dart';

import '../../logic/custom_exception.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationRepository repository = AuthenticationRepository();

  AuthenticationBloc() : super(const AuthenticationInitial()) {
    on<AuthenticationSignInRequested>(_onAuthenticationSignInRequested);
    on<AuthenticationSignUpRequested>(_onAuthenticationSignUpRequested);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogOutRequested);
  }

  FutureOr<void> _onAuthenticationSignInRequested(
      AuthenticationSignInRequested event,
      Emitter<AuthenticationState> emit) async {
    try {
      emit(const AuthenticationLoadingState());
      await repository.SignInUser(email: event.email, password: event.password)
          .then((value) {
        emit(AuthenticatedState(userToken: value['accessToken']));
      });
    } catch (e) {
      if (e is SocketException) {
        print(e.message);
        emit(UnAuthenticatedState(errorMessage: e.message));
      } else if (e is UserNotFoundException) {
        emit(UnAuthenticatedState(errorMessage: e.message));
      } else {
        print('e: $e');
        emit(UnAuthenticatedState(errorMessage: e.runtimeType.toString()));
      }
    }
  }

  FutureOr<void> _onAuthenticationSignUpRequested(
      AuthenticationSignUpRequested event,
      Emitter<AuthenticationState> emit) async {
    try {
      emit(AuthenticationLoadingState());
      await repository.SignUpUser(
              event.first_name,
              event.last_name,
              event.email,
              event.username,
              event.password,
              event.repeat_password)
          .then((value) {
        emit(AuthenticatedState(userToken: value['token']));
      });
    } catch (e) {
      if (e is SocketException) {
        print(e.message);
        emit(UnAuthenticatedState(errorMessage: e.message));
      } else if (e is UserNotFoundException) {
        emit(UnAuthenticatedState(errorMessage: e.message));
      } else {
        print('e: $e');
        emit(UnAuthenticatedState(errorMessage: e.runtimeType.toString()));
      }
    }
  }

  FutureOr<void> _onAuthenticationLogOutRequested(
      AuthenticationLogoutRequested event, Emitter<AuthenticationState> emit) async {
    // emit(AuthenticationLoadingState());
    emit(AuthenticationInitial());
    // await AuthenticationBloc().close();
    // await HydratedBloc.storage.close();
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    try {
      return AuthenticatedState(userToken: json['token']);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    if (state is AuthenticatedState) {
      return {'token': state.token};
    }
    return null;
  }
}
