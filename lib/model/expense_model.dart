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
    final ExpenceCategory category;
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


    //convert the expence object to a json object (serialization)
    Map <String, dynamic> toJson () {
      return {
        'id' : id,
        'title' : title,
        'amount' : amount,
        'category' : category.index,
        'date' : date.toIso8601String(),
        'time' : time.toIso8601String(),
        'description' : description,

      };
    }

    //create an expence object from a json object (deserialization)
    factory Expence.fromJson( Map <String, dynamic> json){
         return Expence(
          id: json['id'], 
          title: json['title'], 
          amount: json['amount'], 
          category: ExpenceCategory.values[json['category']], 
          date: DateTime.parse(json['date']), 
          time: DateTime.parse(json['time']), 
          description: json['description']
          );
    }
}