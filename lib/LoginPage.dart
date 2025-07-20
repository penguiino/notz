// ignore_for_file: prefer_const_constructors

import'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ForgotPage.dart';
import 'SignupPage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({ super.key });

  @override
  State<LoginPage> createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
    );
  }
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
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
                width: 250,
                height: 0,
              ),
              Text(
                'Log in',
                style: TextStyle(fontSize: 30),
              ),

            ],
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/images/logo.png')),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 60,
              width: 300,
              child: TextField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Email',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5),
                        borderRadius: BorderRadius.circular(10.0))),
              ),
            ),


            SizedBox(height: 40),


            SizedBox(height: 60, width: 300,
              child: TextField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: 'password',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5),
                        borderRadius: BorderRadius.circular(10.0))),
                obscureText: true,
              ),
            ),


            SizedBox(height: 40),

            Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                  icon: Icon(Icons.lock_open, size: 32),
                  label: Text(
                    'sign in',
                  ),
                  onPressed: signIn,
                )
            ),

            SizedBox(height: 20),

            GestureDetector(
              onTap:() {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ForgotPage()));
              },
              child: Text('Forgot password'),
            ),

            SizedBox(height: 10),

            GestureDetector(
              onTap:() {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SignUpPage()));
              },
              child: Text('Register now'),
            ),
          ],
        ),
      ),
    );
  }
}