import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const MyWidget(),
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the theme using Theme.of(context)
    final ThemeData theme = Theme.of(context);

    return Container(
      color: theme.primaryColor,
    );
  }
}
