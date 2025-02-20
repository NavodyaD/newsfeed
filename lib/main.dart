import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/data/datasources/firebase_auth_datasource.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/data/repositories/user_repository_impl.dart';
import 'features/authentication/domain/usecases/signup_user.dart';
import 'features/authentication/presentation/cubit/signup_cubit.dart';
import 'features/authentication/presentation/pages/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(
        SignUpUser(
          AuthRepositoryImpl(FirebaseAuthDatasource(FirebaseAuth.instance)),
          UserRepositoryImpl(FirebaseFirestore.instance),
        ),
      ),
      child: MaterialApp(
        title: 'NewsFeed',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: SignUpPage(),
      ),
    );
  }
}
