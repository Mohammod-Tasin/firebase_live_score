import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_live_score/home_screen.dart';
import 'package:firebase_live_score/sign_up_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              const SizedBox(height: 10),
              FilledButton(
                onPressed: _onTapSubmitButton,
                child: Text('Sign In'),
              ),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpScreen()));
                },
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
      _signInUser();
    }
  }

  Future<void> _signInUser() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('User logged in successfully')));
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (_) => HomeScreen()),
      //   (predicate) => false,
      // );
    } on FirebaseAuthException catch (e) {
      showSnackbarMsg(e.message ?? 'Something went wrong');
    } catch (e) {
      showSnackbarMsg(e.toString());
    }
  }

  void showSnackbarMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
