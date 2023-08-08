part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationSignInRequested extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationSignInRequested({required this.email, required this.password});
}

class AuthenticationSignUpRequested extends AuthenticationEvent {
  final String first_name;
  final String last_name;
  final String username;
  final String email;
  final String password;
  final String repeat_password;

  AuthenticationSignUpRequested({
    required this.first_name,
    required this.last_name,
    required this.username,
    required this.email,
    required this.password,
    required this.repeat_password,
  });
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
