//  Dart 3.1
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../provider/themeChangerPRovider.dart';
import '../utilis/CustomElevatedButton.dart';
import '../utilis/CustomTextfeilds.dart';
import 'Registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<themeChangerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Login',
          style: TextStyle(),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ThemeMode.light,
                child: Text("Light Mode"),
              ),
              PopupMenuItem(
                value: ThemeMode.dark,
                child: Text("Dark Mode"),
              ),
            ],
            onSelected: (themeMode) {
              themeChanger.setTheme(themeMode);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Image(
              image: AssetImage(
                'assets/img/1.jpg',
              ),
            ),
          ),
          CustomTextField(
            icon: Icon(Icons.email),
            controller: _emailController,
            labelText: 'Email',
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            icon: Icon(Icons.password),
            controller: _passwordController,
            labelText: 'Password',
            obscureText: true,
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 50,
            width: 150,
            child: CustomElevatedButton(
              onPressed: _login,
              text: 'LOGIN',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const Text(
                  'Need an account?',
                  style: TextStyle(),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationPage()));
                },
                child: const Text(
                  'REGISTER',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              // Container(
              //   height: 50,
              //   width: 150,
              //   child: CustomElevatedButton(
              //     // onPressed: _loginWithGoogle,
              //     text: 'SIGN IN WITH GOOGLE',
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

//function for logging in the firebase
  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('User logged in: ${userCredential.user?.email}');
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RegistrationPage()));
    } catch (e) {}
  }

  // Future<void> _loginWithGoogle() async {
  //   try {
  //     // Trigger Google Sign-In process
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();

  //     if (googleSignInAccount != null) {
  //       // Obtain GoogleSignInAuthentication
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;

  //       // Create GoogleAuthProvider credential
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );

  //       // Sign in with Google credentials
  //       final UserCredential userCredential =
  //           await _auth.signInWithCredential(credential);

  //       print(
  //           'User logged in with Google: ${userCredential.user?.displayName}');
  //       // Navigate to the next screen or perform other actions
  //     }
  //   } catch (e) {
  //     print('Error signing in with Google: $e');
  //   }
  // }
}
