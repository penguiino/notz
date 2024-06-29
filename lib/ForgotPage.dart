// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({ super.key});

  @override
  State<ForgotPage> createState() => _ForgotDemoState();
}

class _ForgotDemoState extends State<ForgotPage> {
  final emailController = TextEditingController();


  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim());
      showDialog(
          context: context, builder: (context) {
        return AlertDialog(
          content: Text('Password reset link sent! Check your email.'),
        );
      });
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      showDialog(
          context: context, builder: (context) {
        return AlertDialog(
          content: Text(errorMessage),
        );
      });
    }
  }

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Column(
            children: const [
              SizedBox(
                width: 120,
                height: 0,
              ),
            ],
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/images/logo.png')),
              ),
            ),

            SizedBox(
              height: 40,
            ),

            SizedBox(
              height: 55,
              child: Text('Enter your Email and we will send you a password reset link',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.blueGrey),
              ),
            ),

            SizedBox(
              height: 40,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: passwordReset,
                child: Text('Reset password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}