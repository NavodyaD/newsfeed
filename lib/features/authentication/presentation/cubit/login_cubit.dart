import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/usecases/login_user.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUser loginUser;

  LoginCubit(this.loginUser) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());
      final user = await loginUser(email, password);
      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

// login success state
class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess(this.user);
}

// login error state
class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
