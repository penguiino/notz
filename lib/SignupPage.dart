// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'LoginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpDemoState();
}

class _SignUpDemoState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future signUp() async {
    if (passwordConfirmed()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        User? user = userCredential.user;

        if (user != null) {
          String uid = user.uid;
          addUserDetails(
            uid,
            nameController.text.trim(),
            '', // Title placeholder
            '', // Phone number placeholder
            emailController.text.trim(),
            '', // Background placeholder
            '', // About Me placeholder
            '', // User photo URL placeholder
            {}, // Empty social links
            [], // Empty contacts array
          );

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Your account has been created.'),
              );
            },
          );
        } else {
          print('User is null after creation');
        }
      } catch (e) {
        print('Error during sign up: $e');
      }
    } else {
      print('Passwords do not match');
    }
  }

  Future<void> addUserDetails(
      String uid,
      String name,
      String title,
      String number,
      String email,
      String background,
      String aboutMe,
      String userPhotoUrl,
      Map<String, String> socialLinks,
      List<String> contacts,
      ) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'Full Name': name,
        'Title': title,
        'Phone Number': number,
        'Email': email,
        'background': background,
        'About Me': aboutMe,
        'userPhotoUrl': userPhotoUrl,
        'Social Links': socialLinks,
        'contacts': contacts,
      });
      print('User details added successfully');
    } catch (e) {
      print('Error adding user details: $e');
    }
  }

  bool passwordConfirmed() {
    return passwordController.text == confirmPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signUp,
              child: Text('Sign Up'),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
              },
              child: Text('Already have an account? Log in.'),
            ),
          ],
        ),
      ),
    );
  }
}
