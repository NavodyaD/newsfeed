import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NewsFeed Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Your Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Your Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  // login success
                } else if (state is LoginError) {
                  // show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    context.read<LoginCubit>().login(
                      emailController.text,
                      passwordController.text,
                    );
                  },
                  child: Text('Login', style: TextStyle(fontSize: 20, color: Colors.black),),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
