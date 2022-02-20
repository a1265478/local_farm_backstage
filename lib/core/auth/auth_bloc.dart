import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_farm_backstage/core/enumKey.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<AddFirebaseAuthListener>(_onAddFirebaseAuthListener);
    on<NotifyAuth>(_onNotifyAuth);
    on<NotifyUnAuth>(_onNotifyUnAuth);
    on<ChangeAccount>(_onChangeAccount);
    on<ChangePassword>(_onChangePassword);
    on<Login>(_onLogin);
  }

  Future<void> _onAddFirebaseAuthListener(
      AddFirebaseAuthListener event, Emitter<AuthState> emit) async {
    try {
      firebaseAuth.authStateChanges().listen((User? user) {
        if (user != null) {
          add(NotifyAuth());
        } else {
          add(NotifyUnAuth());
        }
      });
    } catch (ex) {}
  }

  Future<void> _onNotifyAuth(NotifyAuth event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.success));
  }

  Future<void> _onNotifyUnAuth(
      NotifyUnAuth event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.init));
  }

  Future<void> _onChangeAccount(
      ChangeAccount event, Emitter<AuthState> emit) async {
    emit(state.copyWith(account: event.account));
  }

  Future<void> _onChangePassword(
      ChangePassword event, Emitter<AuthState> emit) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.working));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: state.account, password: state.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found" || e.code == "wrong-password") {
        return emit(
            state.copyWith(status: Status.failure, errorMsg: "帳號或密碼錯誤"));
      }
      emit(state.copyWith(status: Status.failure, errorMsg: "登入失敗"));
    } catch (ex) {
      emit(state.copyWith(status: Status.failure, errorMsg: "登入失敗"));
    }
  }
}
