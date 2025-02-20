// signup cubit
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/signup_user.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUser signUpUser;

  SignUpCubit(this.signUpUser) : super(SignUpInitial());

  Future<void> signUp(String email, String password, String name, List<String> interests) async {
    try {
      emit(SignUpLoading());
      final user = await signUpUser(email, password, name, interests);
      emit(SignUpSuccess(user));
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }
}

abstract class SignUpState {}
class SignUpInitial extends SignUpState {}
class SignUpLoading extends SignUpState {}
class SignUpSuccess extends SignUpState {
  final User user;
  SignUpSuccess(this.user);
}
class SignUpError extends SignUpState {
  final String message;
  SignUpError(this.message);
}
