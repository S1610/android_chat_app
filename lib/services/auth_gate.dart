import 'package:android_chat_app/pages/chat_page.dart';
import 'package:android_chat_app/pages/home_page.dart';
import 'package:android_chat_app/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return GroupChat();
          }

          //user is NOT logged in
          else{
            return SignInPage2();
          }
        },
        ),
    );
  }
}