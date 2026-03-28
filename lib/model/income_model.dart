import 'package:flutter/material.dart';

enum IncomeCategory {
  freelance,
  salary,
  passive,
  sales,
}

//category images
final Map<IncomeCategory , String> incomeCategoryImages = {
      IncomeCategory.freelance : "assets/images/freelance.png",
      IncomeCategory.salary : "assets/images/health.png",
      IncomeCategory.passive : "assets/images/car.png",
      IncomeCategory.sales : "assets/images/salary.png",
};

//category colors
final Map<IncomeCategory , Color> incomeCategoryColors = {
    IncomeCategory.freelance : Color(0XFFE57373),
    IncomeCategory.salary : Color(0XFF81C784),
    IncomeCategory.passive : Color(0XFF64B5F6),
    IncomeCategory.sales : Color(0XFFFFD54F),
};

  class Income {
    final int id;
    final String title;
    final double amount;
    final IncomeCategory category;
    final DateTime date;
    final DateTime time;
    final String description;

  Income({
    required this.id, 
    required this.title, 
    required this.amount, 
    required this.category, 
    required this.date, 
    required this.time, 
    required this.description
    });


  }
