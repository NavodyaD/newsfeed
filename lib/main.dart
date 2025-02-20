import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/data/datasources/firebase_auth_datasource.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/data/repositories/user_repository_impl.dart';
import 'features/authentication/domain/usecases/login_user.dart';
import 'features/authentication/domain/usecases/signup_user.dart';
import 'features/authentication/presentation/cubit/login_cubit.dart';
import 'features/authentication/presentation/cubit/signup_cubit.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/authentication/presentation/pages/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SignUpCubit(
            SignUpUser(
              AuthRepositoryImpl(FirebaseAuth.instance as FirebaseAuthDatasource),
              UserRepositoryImpl(FirebaseFirestore.instance),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => LoginCubit(
            LoginUser(AuthRepositoryImpl(FirebaseAuth.instance as FirebaseAuthDatasource)),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Auth App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: SignUpPage(),
      ),
    );
  }
}
