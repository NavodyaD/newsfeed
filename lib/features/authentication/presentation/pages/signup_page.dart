import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/signup_cubit.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  List<String> selectedInterests = [];

  final List<String> interests = [
    'Business',
    'Auto Mobile',
    'Politics',
    'Daily News',
    'Sports',
    'Nature',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            Text('Select Your News Interests:'),
            ...interests.map((interest) {
              return CheckboxListTile(
                title: Text(interest),
                value: selectedInterests.contains(interest),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedInterests.add(interest);
                    } else {
                      selectedInterests.remove(interest);
                    }
                  });
                },
              );
            }).toList(),
            BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  // Navigate to home or login page
                } else if (state is SignUpError) {
                  // Show error
                }
              },
              builder: (context, state) {
                if (state is SignUpLoading) {
                  return CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    context.read<SignUpCubit>().signUp(
                      emailController.text,
                      passwordController.text,
                      nameController.text,
                      selectedInterests,
                    );
                  },
                  child: Text('Sign Up'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
