import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              textAlign: TextAlign.center,
              "Financial Report", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
          ],
        ),
      )),
    );
  }
}