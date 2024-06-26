import 'package:emi_calculator/input_screen.dart';
import 'package:emi_calculator/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoanSelectionPage extends StatefulWidget {
  const LoanSelectionPage({super.key});

  @override
  State<LoanSelectionPage> createState() => _LoanSelectionPageState();
}

class _LoanSelectionPageState extends State<LoanSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EMI Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReusableCard(
            label: 'Home loan',
            icon: FontAwesomeIcons.house,
            onPress: () {
              //Navigator.pushNamed(context, '/input');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InputScreen()),
              );
            },
          ),
          ReusableCard(
            label: 'Car loan',
            icon: FontAwesomeIcons.car,
            onPress: () {
              print("Car loan tapped");
            },
          ),
          ReusableCard(
            label: 'Personal loan',
            icon: FontAwesomeIcons.handHoldingDollar,
            onPress: () {
              print("Personal loan tapped");
            },
          ),
        ],
      ),
    );
  }
}
