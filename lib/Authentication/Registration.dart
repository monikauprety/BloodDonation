//  Dart 3.1
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utilis/CustomElevatedButton.dart';
import '../utilis/CustomTextfeilds.dart';
import 'LoginUser.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: _emailController,
              labelText: 'Email',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: _passwordController,
              labelText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 50,
              width: 150,
              child: CustomElevatedButton(
                onPressed: _register,
                text: 'LOGIN',
              ),
            ),
          ],
        ),
      ),
    );
  }
  //function for registration

  Future<void> _register() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print("Registered");
      // Navigate to the login page on successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } catch (e) {
      // If the email is already in use, show an alert
      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        _showErrorAlert('Email Already Registered',
            'The provided email address is already registered. Please use a different email.');
      }
      // You can handle other registration errors here
    }
  }

  void _showErrorAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
