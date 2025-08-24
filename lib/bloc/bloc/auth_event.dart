part of 'auth_bloc.dart';

sealed class AuthEvent {}

class RegisterAuthEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterAuthEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}
