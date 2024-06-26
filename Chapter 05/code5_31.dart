import 'dart:math';
import 'package:flutter/material.dart';
import 'custom_slider.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  double loanAmount = 2500000;
  double tenureInYears = 30;
  double interestRate = 8.8;
  double emi = 0;

  // Function to calculate EMI
  double calculateEMI() {
    double principal = loanAmount;
    double monthlyInterestRate = (interestRate / 12) / 100;
    int totalMonths = (tenureInYears * 12).toInt();

    if (monthlyInterestRate == 0) {
      return principal / totalMonths;
    } else {
      double emi = principal *
          monthlyInterestRate *
          (pow(1 + monthlyInterestRate, totalMonths)) /
          (pow(1 + monthlyInterestRate, totalMonths) - 1);
      return emi;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EMI Calculator"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSlider(
            title: "Loan Amount",
            minValue: 100000,
            maxValue: 100000000,
            initialValue: 2500000,
            preText: "₹",
            onValueChanged: (newValue) {
              Future.delayed(Duration.zero, () {
                setState(() {
                  loanAmount = newValue;
                });
              });
            },
          ),
          CustomSlider(
            title: "Tenure (Years)",
            minValue: 1,
            maxValue: 30,
            initialValue: 30,
            onValueChanged: (newValue) {
              Future.delayed(Duration.zero, () {
                setState(() {
                  tenureInYears = newValue;
                });
              });
            },
          ),
          CustomSlider(
            title: "Interest Rate (% P.A.)",
            minValue: 0.5,
            maxValue: 15,
            initialValue: 8.8,
            onValueChanged: (newValue) {
              Future.delayed(Duration.zero, () {
                setState(() {
                  interestRate = newValue;
                });
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              double calculatedEMI = calculateEMI();
              setState(() {
                emi = calculatedEMI;
              });
              print('EMI: $emi');
            },
            child: const Text('Calculate'),
          ),
          const SizedBox(height: 20),
          Text(
            'EMI: ₹${emi.toStringAsFixed(2)}',
            // Display the calculated EMI
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
