import 'package:flutter/material.dart';

void main() => runApp(const EMICalculator());

class EMICalculator extends StatelessWidget {
  const EMICalculator({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(color: Color(0XFF0564EB)),
          scaffoldBackgroundColor: const Color(0XFFF2F6FA)),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0XFF00e7f8),
              borderRadius: BorderRadius.circular(5.0),
            ),
            height: 100,
            width: double.infinity,
            child: const Center(
              child: Text(
                "Home Loan",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0XFF00e7f8),
              borderRadius: BorderRadius.circular(5.0),
            ),
            height: 100,
            width: double.infinity,
            child: const Center(
              child: Text(
                "Personal Loan",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0XFF00e7f8),
              borderRadius: BorderRadius.circular(5.0),
            ),
            height: 100,
            width: double.infinity,
            child: const Center(
              child: Text(
                "Car Loan",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
