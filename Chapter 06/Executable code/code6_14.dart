import 'package:flutter/material.dart';

class MyLoadingScreen extends StatelessWidget {
  const MyLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(), // Display a simple spinner
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Spinner Widget Example'),
      ),
      body: const MyLoadingScreen(),
    ),
  ));
}
