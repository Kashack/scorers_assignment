part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  loading,
  error
}
@immutable
abstract class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final String? errorMessage;
  final String token;

  const AuthenticationState(
      {this.status = AuthenticationStatus.unknown,
      this.errorMessage,
      this.token = ''
      });
  @override
  List<Object> get props => [status,token];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial() : super(status: AuthenticationStatus.unknown);
}

class AuthenticationActionState extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {
  final String userToken;

  const AuthenticatedState({required this.userToken})
      : super(status: AuthenticationStatus.authenticated, token: userToken);
}

class AuthenticationLoadingState extends AuthenticationState {
  const AuthenticationLoadingState() : super(status: AuthenticationStatus.loading);
}

class UnAuthenticatedState extends AuthenticationState {
  final String errorMessage;

  const UnAuthenticatedState({required this.errorMessage})
      : super(status: AuthenticationStatus.unauthenticated);
}
