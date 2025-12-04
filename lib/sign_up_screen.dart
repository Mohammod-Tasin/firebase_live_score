import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_live_score/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Sign Up Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 8,
            children: [
              const SizedBox(height: 48),
              TextFormField(
                controller: _emailController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(hintText: 'Email'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter a valid email';
                  }
                },
              ),
              TextFormField(
                controller: _passwordController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(hintText: 'Password'),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter a valid password';
                  }
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(hintText: 'Confirm password'),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter a valid password';
                  } else if (value! != _passwordController.text) {
                    return "Confirm password doesn't match";
                  }
                },
              ),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: _onTapSubmitButton,
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _createNewUser();
    }
  }

  Future<void> _createNewUser() async {
    try{
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      showSnackbarMsg('New user registered successfully');
      Navigator.pop(context);
    } on FirebaseAuthException catch (e){
      if (e.code == 'weak-password') {
        showSnackbarMsg('Use a stronger password');
      } else if (e.code == 'email-already-in-use') {
        showSnackbarMsg('The account already exists for that email');
      }
    } catch(e){
      showSnackbarMsg(e.toString());
    }
  }

  void showSnackbarMsg(String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
