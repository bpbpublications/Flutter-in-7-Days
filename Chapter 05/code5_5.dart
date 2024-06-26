import 'package:flutter/material.dart';

void main() => runApp(const EMICalculator());

class EMICalculator extends StatelessWidget {
  const EMICalculator({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.blueGrey,
            secondary: Colors.teal,
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Color(0XFFab3d00),
            ),
          )),
      debugShowCheckedModeBanner: false,
      home: const UserInputPage(),
    );
  }
}

class UserInputPage extends StatefulWidget {
  const UserInputPage({super.key});

  @override
  State<UserInputPage> createState() => _UserInputPageState();
}

class _UserInputPageState extends State<UserInputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EMI Calculator')),
      body: const Center(child: Text('body text')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
