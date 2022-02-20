part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AddFirebaseAuthListener extends AuthEvent {}

class NotifyAuth extends AuthEvent {}

class NotifyUnAuth extends AuthEvent {}

class ChangeAccount extends AuthEvent {
  final String account;
  ChangeAccount({required this.account});
}

class ChangePassword extends AuthEvent {
  final String password;
  ChangePassword({required this.password});
}

class Login extends AuthEvent {}
