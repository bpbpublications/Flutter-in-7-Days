import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/screens/shopping_list.screen.dart';
import 'package:shopping_list/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  bool isLoggingIn = false;

  Future<void> _signInWithEmailAndPassword() async {
    setState(() {
      isLoggingIn = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (!mounted) return;

      Navigator.pushNamed(context, ShoppingListScreen.id);
    } catch (e) {
      String errorMessage = "";

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage = "User not found. Please check your email.";
            break;
          case 'wrong-password':
            errorMessage = "Invalid password. Please try again.";
            break;
          case 'invalid-email':
            errorMessage = "Invalid email format. Please enter a valid email.";
            break;
          default:
            errorMessage = "Authentication failed. Please try again.";
            break;
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        isLoggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 250.0,
              child: DefaultTextStyle(
                style: const TextStyle(
                    fontSize: 30.0, fontFamily: 'Agne', color: Colors.black),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Shopping List'),
                  ],
                ),
              ),
            ),
            Image.asset(
              'images/logo.jpg',
              height: 100.0,
              width: 100.0,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              onChanged: (value) {
                email = value;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              onChanged: (value) {
                password = value;
              },
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: isLoggingIn ? null : _signInWithEmailAndPassword,
              child: isLoggingIn
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 10),
                        Text('Logging In'),
                      ],
                    )
                  : const Text('Login'),
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: isLoggingIn
                      ? null
                      : () {
                          Navigator.pushNamed(context, SignUpScreen.id);
                        },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
