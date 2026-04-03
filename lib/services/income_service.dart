import 'dart:convert';

import 'package:expenz_app/model/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


//first create a class
class IncomeService {

 
//make a key
  static const String _incomeKey = 'incomes';
//save income in shared preference
  Future<void> saveIncomes(Income income, BuildContext context) async {
    try{
      //make instance
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List <String>? existingIncomes = prefs.getStringList(_incomeKey);

      List<Income> existingIncomesObject = [];
      if(existingIncomes != null){
        existingIncomesObject = existingIncomes.map((e) => Income.fromJson(json.decode(e))).toList();
      }
      existingIncomesObject.add(income);

      List<String> updatedIncomes = existingIncomesObject.map((e) => json.encode(e.toJson()),).toList();

      await prefs.setStringList(_incomeKey, updatedIncomes);

      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Income added successfully!"),
            duration: Duration(seconds: 2),
            ),
        );
      }
    }catch(error){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error and adding Incomes"),
          duration: Duration(seconds: 2),
          )
        );
      }
    }
  }

  Future <List<Income>> loadIncomes () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingIncomes = prefs.getStringList(_incomeKey);

    List<Income> loadedIncomes = [];
    if(existingIncomes != null){
      loadedIncomes = existingIncomes.map((e) => Income.fromJson(json.decode(e)),).toList();
    }
    return loadedIncomes;
  }
}