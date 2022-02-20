part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final Status status;
  final String errorMsg;
  final String account;
  final String password;

  const AuthState({
    this.status = Status.init,
    this.errorMsg = "",
    this.account = "",
    this.password = "",
  });

  AuthState copyWith({
    Status? status,
    String? errorMsg,
    String? account,
    String? password,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      account: account ?? this.account,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [status, errorMsg, account, password];
}

class AuthInitial extends AuthState {}
