import 'package:flutter/material.dart';

import 'input_screen.dart';
import 'loan_selection_page.dart';

void main() => runApp(const EMICalculator());

class EMICalculator extends StatelessWidget {
  const EMICalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(color: Color(0XFF0564EB)),
        scaffoldBackgroundColor: const Color(0XFFF2F6FA),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => const LoanSelectionPage(), // Loan Selection Screen
        '/input': (context) => const InputScreen(), // Input Screen
      },
    );
  }
}
