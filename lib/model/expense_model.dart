import 'package:expenz_app/model/income_model.dart';
import 'package:flutter/material.dart';

enum ExpenceCategory {
  food,
  transport,
  health,
  shopping,
  subscription,
}

//category images
final Map<ExpenceCategory , String> expenceCategoriesImages = {
   ExpenceCategory.food : "assets/images/restaurant.png",
   ExpenceCategory.transport : "assets/images/car.png",
   ExpenceCategory.health : "assets/images/health.png",
   ExpenceCategory.shopping : "assets/images/bag.png",
   ExpenceCategory.subscription : "assets/images/bill.png",
};

//category colors
final Map<ExpenceCategory , Color> expenceCategoriesColors = {
  ExpenceCategory.food : Color(0XFFE57373),
  ExpenceCategory.transport : Color(0XFF81C784),
  ExpenceCategory.health : Color(0XFF6485F6),
  ExpenceCategory.shopping : Color(0XFFFFD54F),
  ExpenceCategory.subscription : Color(0XFF9575CD),
};

//model
class Expence {
   final int id;
    final String title;
    final double amount;
    final IncomeCategory category;
    final DateTime date;
    final DateTime time;
    final String description;

  Expence({
    required this.id, 
    required this.title, 
    required this.amount, 
    required this.category, 
    required this.date, 
    required this.time, 
    required this.description});
}