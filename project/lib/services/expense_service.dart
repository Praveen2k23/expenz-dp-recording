import 'dart:convert'; // For converting objects to and from JSON
import 'package:flutter/material.dart'; // Flutter UI components
import 'package:project/model/expens_model.dart'; // Your custom Expense model
import 'package:shared_preferences/shared_preferences.dart'; // For local storage

class ExpenseService {
  // Key used to store/retrieve the expense list from SharedPreferences
  static String _expenseKey = 'expenses';

  // Function to save a new expense entry into SharedPreferences
  Future<void> saveExpenses(Expense expence, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      List<Expense> existingExpensesObjects = [];
      if (existingExpenses != null) {
        existingExpensesObjects = existingExpenses
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }

      existingExpensesObjects.add(expence);

      List<String> updatedExpenses = existingExpensesObjects
          .map((e) => json.encode(e.toJSON()))
          .toList();

      await prefs.setStringList(_expenseKey, updatedExpenses);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expense added Successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingExpenses = prefs.getStringList(_expenseKey);

    List<Expense> loadedExpenses = [];
    if (existingExpenses != null) {
      loadedExpenses = existingExpenses
          .map((e) => Expense.fromJSON(json.decode(e)))
          .toList();
    }

    return loadedExpenses;
  }

  // Delete the expense from SharedPreferences using the id
  Future<void> deleteExpense(int id, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingExpenses = pref.getStringList(_expenseKey);

      List<Expense> existingExpenseObjects = [];
      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }

      existingExpenseObjects.removeWhere((element) => element.id == id);

      List<String> updatedExpenses =
          existingExpenseObjects.map((e) => json.encode(e.toJSON())).toList();

      await pref.setStringList(_expenseKey, updatedExpenses);

      // Show snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Expense deleted successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Delete all expenses from SharedPreferences
  Future<void> deleteAllExpenses(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_expenseKey); // Fixed typo here

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error deleting'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
