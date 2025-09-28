part of 'auth_cubit.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}

class AuthSuccess extends AuthenticationState {
  final String message;

  AuthSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends AuthenticationState {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
