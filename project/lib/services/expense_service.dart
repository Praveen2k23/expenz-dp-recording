import 'dart:convert'; // For converting objects to and from JSON
import 'package:flutter/material.dart'; // Flutter UI components
import 'package:project/model/expens_model.dart'; // Your custom Expense model
import 'package:shared_preferences/shared_preferences.dart'; // For local storage

class ExpenseService {
  // List to hold expenses temporarily (not currently used)
  List<Expense> expenceList = [];

  // Key used to store/retrieve the expense list from SharedPreferences
  static String _expenseKey = 'expenses';


  // Function to save a new expense entry into SharedPreferences
  Future<void> saveExpenses(Expense expence, BuildContext context) async {
    try {
      // Get the instance of SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Try to get the list of existing expenses from SharedPreferences
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);




      // Create a list to hold existing expense objects (converted from JSON)
      List<Expense> existingExpensesObjects = [];

      // If data exists, decode JSON strings into Expense objects
      if (existingExpenses != null) {
        existingExpensesObjects = existingExpenses
            .map((e) => Expense.fromJSON(json.decode(e))) // decode JSON -> Map -> Expense
            .toList();
      }



      // Add the new expense object to the existing list
      existingExpensesObjects.add(expence);

      // Convert the updated list of Expense objects back into a list of JSON strings
      List<String> updatedExpenses = existingExpensesObjects
          .map((e) => json.encode(e.toJSON())) // Expense -> Map -> JSON string
          .toList();

      // Save the updated list back to SharedPreferences
      await prefs.setStringList(_expenseKey, updatedExpenses);



      // Show a success message if the widget is still mounted in the widget tree
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expense added Successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }



    } catch (error) {
      // Handle any error (e.g., during saving or JSON encoding)

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error on Adding Expenses"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

// Function to load the expenses from SharedPreferences
Future<List<Expense>> loadExpenses() async {
  // Get instance of SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Retrieve the list of stored expense JSON strings
  List<String>? existingExpenses = prefs.getStringList(_expenseKey);

  // Create an empty list to hold decoded Expense objects
  List<Expense> loadedExpenses = [];

  // If expenses exist in storage, decode each one and convert to Expense object
  if (existingExpenses != null) {
    loadedExpenses = existingExpenses
        .map((e) => Expense.fromJSON(json.decode(e))) // decode JSON string -> Map -> Expense
        .toList();
  }

  // Return the list of Expense objects
  return loadedExpenses;
}

}
