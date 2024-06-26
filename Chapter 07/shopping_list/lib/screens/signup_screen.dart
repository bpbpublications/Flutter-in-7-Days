import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_list/screens/shopping_list.screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  bool isLoggingIn = false;

  Future<void> _createAccountWithEmailAndPassword() async {
    setState(() {
      isLoggingIn = true;
    });
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!mounted) return;
      Navigator.pushNamed(context, ShoppingListScreen.id);
    } catch (e) {
      String errorMessage = "An error occurred during account creation.";

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage =
                "The email address is already in use by another account.";
            break;
          case 'invalid-email':
            errorMessage = "The email address is invalid.";
            break;
          case 'weak-password':
            errorMessage = "The password is too weak.";
            break;
          default:
            errorMessage = "Account creation failed. Please try again.";
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
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //_auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text('Sign up'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                setState(() {
                  email = value;
                });
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
                setState(() {
                  password = value;
                });
              },
            ),

            const SizedBox(height: 24.0),

            // Login Button
            ElevatedButton(
              onPressed:
                  isLoggingIn ? null : _createAccountWithEmailAndPassword,
              child: isLoggingIn
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 10),
                        Text('Sign up'),
                      ],
                    )
                  : const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
