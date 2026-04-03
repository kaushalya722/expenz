import 'dart:convert';

import 'package:expenz_app/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenceService {

  //expence list 
  

  //define the key for sharing expences in shared preferences
  static const String _expenceKey = 'expences';

  //save the expences to shared preferences
  Future<void> saveExpences(Expence expence, BuildContext context) async {
     try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List <String>? existingExpences = prefs.getStringList(_expenceKey);

      //convert the existing expences to a list of expence object
      List<Expence> existingExpencesObjects = [];

      if(existingExpences != null){
        existingExpencesObjects = existingExpences.map((e) => Expence.fromJson(json.decode(e))).toList();
      }

      //add the new expence to the list
      existingExpencesObjects.add(expence);

      // convert the list of Expence Object back to a list of strings
      List<String> updatedExpences = existingExpencesObjects.map((e) => json.encode(e.toJson()),).toList();

      //save the updated list of expences to shared preferences
      await prefs.setStringList(_expenceKey, updatedExpences); 

      //show message
      if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Expense added successfully'),
          duration: Duration(seconds: 2),
        ),
      );
     }
     }catch(error){
      if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error an adding Expenses'),
          duration: Duration(seconds: 2),
        ),
      );
     }
     }
  }

  // load the expences from shared preferences
  Future <List<Expence>> loadExpences () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingExpences = prefs.getStringList(_expenceKey);

    //convert the existig expences to the list of expence object
    List<Expence> loadedExpences =[];
    if(existingExpences != null){
      loadedExpences = existingExpences.map((e) => Expence.fromJson(json.decode(e)),).toList();

    }
    return loadedExpences;

  }
}