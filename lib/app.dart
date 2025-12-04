import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_live_score/sign_in_screen.dart';
import 'package:firebase_live_score/sign_up_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class FootballLiveScoreApp extends StatefulWidget {
  const FootballLiveScoreApp({super.key});

  @override
  State<FootballLiveScoreApp> createState() => _FootballLiveScoreAppState();
}

class _FootballLiveScoreAppState extends State<FootballLiveScoreApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, asyncSnapshots) {
          if (asyncSnapshots.hasData) {
            return const HomeScreen();
          }  else{
            return SignInScreen();
          }
          /// app e uporer ei kaj ta korar dara ami command dilam je, jodi app e auth state change hoy , meaning->
          /// jodi sign in ba sign up hoy tahole <User?> er moddhe credential gulo chole jabe ar asyncSnapshot e
          /// datagula load hobe, ar is else bola hoise je, asyncSnapshot e data thakle homeScreen e chole jabe ar
          /// na thakle Sign In screen e jabe. eta puro application er jonno.
        }
      ),
    );
  }
}
