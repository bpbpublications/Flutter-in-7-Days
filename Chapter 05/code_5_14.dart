import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ReusableCard.dart';

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
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReusableCard(
            label: 'Home loan',
            icon: FontAwesomeIcons.house,
          ),
          ReusableCard(
            label: 'car loan',
            icon: FontAwesomeIcons.car,
          ),
          ReusableCard(
            label: 'Personal loan',
            icon: FontAwesomeIcons.handHoldingDollar,
          ),
        ],
      ),
    );
  }
}
