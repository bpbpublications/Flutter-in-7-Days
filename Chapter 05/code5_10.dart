import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final String label;

  const ReusableCard({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0XFF00e7f8),
        borderRadius: BorderRadius.circular(5.0),
      ),
      height: 100,
      width: double.infinity,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
