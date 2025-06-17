import 'package:flutter/material.dart';

// Importing project-specific files and resources
import 'package:project/constant/colors.dart'; // Custom colors
import 'package:project/model/expens_model.dart'; // Expense model
import 'package:project/model/income_model.dart';
import 'package:project/screens/add_new_screen.dart'; // Screen to add a new expense
import 'package:project/screens/budget_screen.dart'; // Budget screen
import 'package:project/screens/home_screen.dart'; // Home screen
import 'package:project/screens/profile_screen.dart'; // Profile screen
import 'package:project/screens/transaction_screen.dart'; // Transactions screen
import 'package:project/services/expense_service.dart';
import 'package:project/services/income_service.dart'; // Expense service to handle saving/loading

// Main widget that contains bottom navigation and switches between pages
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Keeps track of the current selected tab index
  int _currentPageIndex = 0;

  // List to hold expenses retrieved from local storage
  List<Expense> expenseList = [];
  List<Income> incomeList = [];

  // Function to load all expenses from shared preferences
  void fetchAllExpenses() async {
    List<Expense> loadExpenses = await ExpenseService().loadExpenses();

    // Update the UI when data is loaded
    setState(() {
      expenseList = loadExpenses;
      print(expenseList.length);
    });
  }

  void fetchAllIncomes() async {
    List<Income> loadIncomes = await IncomeService().loadIncomes();
    setState(() {
      incomeList = loadIncomes;
      print(incomeList.length);
    });
  }

  @override
  void initState() {
    // Load the saved expenses when the widget is initialized
    setState(() {
      fetchAllExpenses();
      fetchAllIncomes();
    });
    super.initState();
  }

  // Function to add a new expense
  void addNewExpense(Expense newExpense) {
    // Save the expense to shared preferences
    ExpenseService().saveExpenses(newExpense, context);

    // Update the UI immediately
    setState(() {
      expenseList.add(newExpense);
    });
  }

  // Function to delete an expense
  void removeExpense(Expense expense) {
    // Delete the expense from shared preferences
    ExpenseService().deleteExpense(expense.id, context);

    // Update the list of expenses
    setState(() {
      expenseList.remove(expense);
    });
  }

  // Function to add a new income
  void addNewIncome(Income newIncome) {
    // Save the expense to shared preferences
    IncomeService().saveIncome(newIncome, context);

    // Update the UI immediately
    setState(() {
      incomeList.add(newIncome);
    });
  }

  // Function to delete an income
  void removeIncome(Income income) {
    // Delete the income from shared preferences
    IncomeService().deleteIncome(income.id, context);

    // Update the list of incomes
    setState(() {
      incomeList.remove(income);
    });
  }

  //category total expenses
  Map<ExpenceCategory, double> calculateExpensesCategories() {
    Map<ExpenceCategory, double> categoryTotals = {
      ExpenceCategory.food: 0,
      ExpenceCategory.transport: 0,
      ExpenceCategory.shopping: 0,
      ExpenceCategory.health: 0,
      ExpenceCategory.subscriptions: 0,
    };

    for (Expense expense in expenseList) {
      categoryTotals[expense.category] =
          categoryTotals[expense.category]! + expense.amount;
    }

    //print the food category total
    // print(categoryTotals[ExpenseCategory.health].runtimeType);

    return categoryTotals;
  }

  //category total income
  Map<IncomeCategory, double> calculateIncomeCategories() {
    Map<IncomeCategory, double> categoryTotals = {
      IncomeCategory.salary: 0,
      IncomeCategory.freelance: 0,
      IncomeCategory.passive: 0,
      IncomeCategory.sales: 0,
    };

    for (Income income in incomeList) {
      categoryTotals[income.category] =
          categoryTotals[income.category]! + income.amount;
    }

    //print the food category total
    // print(categoryTotals[IncomeCategory.salary].runtimeType);

    return categoryTotals;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(expensesList: expenseList, incomeList: incomeList),
      TransactionScreen(
        expensesList: expenseList,
        onDismissedExpense: removeExpense,
        incomeList: incomeList,
        onDismissedIncome: removeIncome,
      ),
      AddNewScreen(addExpense: addNewExpense, addIncome: addNewIncome),
      BudgetScreen(
        expenseCategoryTotals: calculateExpensesCategories(),
        incomeCategoryTotals: calculateIncomeCategories(),
      ),
      ProfileScreen(),
    ];

    return Scaffold(
      // ... rest of your Scaffold code
      // Bottom navigation bar for page switching
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fixed layout
        backgroundColor: kWhite, // Background color from constants
        selectedItemColor: kMainColor, // Active icon color
        unselectedItemColor: kGrey, // Inactive icon color
        currentIndex: _currentPageIndex, // Current selected tab index
        // Called when a tab is tapped
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },

        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),

        // Bottom navigation items (icons + labels)
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.add, size: 35, color: kWhite),
              ),
            ),
            label: "Add",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.rocket), label: "Budget"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),

      // Display the current page based on selected index
      body: pages[_currentPageIndex],
    );
  }
}
