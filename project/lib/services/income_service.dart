import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project/model/income_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  // Key used to store/retrieve the income list from SharedPreferences
  static const String _incomeKey = 'income';

  // Function to save a new income entry into SharedPreferences
  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      // Get the instance of SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Try to get the list of existing incomes from SharedPreferences
      List<String>? existingIncome = prefs.getStringList(_incomeKey);

      // Create a list to hold existing income objects (converted from JSON)
      List<Income> existingIncomeObjects = [];

      // If data exists, decode JSON strings into Income objects
      if (existingIncome != null) {
        existingIncomeObjects = existingIncome
            .map((e) => Income.fromJSON(json.decode(e))) // JSON string → Map → Income
            .toList();
      }

      // Add the new income object to the existing list
      existingIncomeObjects.add(income);

      // Convert the updated list back into a list of JSON strings
      List<String> updatedIncome = existingIncomeObjects
          .map((e) => json.encode(e.toJSON())) // Income → Map → JSON string
          .toList();

      // Save the updated list back to SharedPreferences
      await prefs.setStringList(_incomeKey, updatedIncome);

      // Show a success message if the context is still mounted
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income added successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      // Handle any error during saving or JSON encoding
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error Adding Income "),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // Function to load the Income from SharedPreferences
Future<List<Income>> loadIncomes() async {
  // Get instance of SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Retrieve the list of stored Income JSON strings
  List<String>? existingIncome = prefs.getStringList(_incomeKey);

  // Create an empty list to hold decoded Income objects
  List<Income> loadedIncomes = [];

  // If expenses exist in storage, decode each one and convert to Income object
  if (existingIncome != null) {
    loadedIncomes = existingIncome
        .map((e) => Income.fromJSON(json.decode(e))) // decode JSON string -> Map -> Income
        .toList();
  }

  // Return the list of Income objects
  return loadedIncomes;
}



    // Function to delete an income
  Future<void> deleteIncome(int id, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      // Convert the existing incomes to a list of Income objects
      List<Income> existingIncomeObjects = [];
      if (existingIncomes != null) {
        existingIncomeObjects = existingIncomes
            .map((e) => Income.fromJSON(json.decode(e)))
            .toList();
      }

      // Remove the income with the given id from the list
      existingIncomeObjects.removeWhere((element) => element.id == id);

      // Convert the list of Income objects back to a list of strings
      List<String> updatedIncomes =
          existingIncomeObjects.map((e) => json.encode(e.toJSON())).toList();

      // Save the updated list of incomes to shared preferences
      await prefs.setStringList(_incomeKey, updatedIncomes);

      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Income deleted successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  
  // Function to delete all incomes
  Future<void> deleteAllIncomes(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Clear all incomes from shared preferences
      await prefs.remove(_incomeKey);

      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All incomes deleted successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
