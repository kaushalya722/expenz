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

  //delete incomes from the shared preference from the id
  Future <void> deleteIncome(int id, BuildContext context) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      //convert the existing incomes to a list of Expence object
      List<Income> existingIncomesObject = [];
      if(existingIncomes != null){
        existingIncomesObject = existingIncomes.map((e) => Income.fromJson(json.decode(e))).toList();

      }

      //remove the income with the specified id from the list
      existingIncomesObject.removeWhere((income) => income.id == id);

      //convert the list of income object back to a list of string
      List<String> updatedIncome = existingIncomesObject.map((e) => json.encode(e.toJson()),).toList();

      //save the updated list of incomes into shared preference
      await prefs.setStringList(_incomeKey, updatedIncome);

      //show snack bar
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Income deleted successfully!"), 
          duration: Duration(seconds: 2),)
        );
      }
    }catch(error){
      print(error.toString());

      //show snack bar
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error deleting Incomes!"),
          duration: Duration(seconds: 2),
          )
        );
      }
    }
  }
}