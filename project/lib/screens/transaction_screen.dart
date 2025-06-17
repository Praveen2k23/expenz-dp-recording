import 'package:flutter/material.dart';
import 'package:project/constant/colors.dart';
import 'package:project/constant/constants.dart';
import 'package:project/model/expens_model.dart';
import 'package:project/model/income_model.dart';
import 'package:project/widgets/expense_card.dart';
import 'package:project/widgets/income_card.dart';

class TransactionScreen extends StatefulWidget {
  final void Function(Expense) onDismissedExpense;
  final void Function(Income) onDismissedIncome;

  final List<Expense> expensesList;
  final List<Income> incomeList;

  const TransactionScreen({
    super.key,
    required this.expensesList,
    required this.onDismissedExpense,
    required this.incomeList,
    required this.onDismissedIncome,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kDefalutPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "See Your financial report",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kMainColor,
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Expenses",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),

              SizedBox(height: 20),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.expensesList.isEmpty
                          ? Text(
                            "No expenses added yet, add some expenses to see here",
                            style: TextStyle(fontSize: 16, color: kGrey),
                          )
                          : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.expensesList.length,
                            itemBuilder: (context, index) {
                              final expense = widget.expensesList[index];

                              return Dismissible(
                                key: ValueKey(expense),
                                direction: DismissDirection.startToEnd,
                                onDismissed: (direction) {
                                  setState(() {
                                    widget.onDismissedExpense(expense);
                                  });
                                },
                                child: ExpenseCard(
                                  title: expense.title,
                                  date: expense.date,
                                  amount: expense.amount,
                                  category: expense.category,
                                  description: expense.description,
                                  time: expense.time,
                                ),
                              );
                            },
                          ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Income",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),

              SizedBox(height: 20),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.incomeList.isEmpty
                          ? Text(
                            "No income added yet, add some income to see here",
                            style: TextStyle(fontSize: 16, color: kGrey),
                          )
                          : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.incomeList.length,
                            itemBuilder: (context, index) {
                              final income = widget.incomeList[index];

                              return Dismissible(
                                key: ValueKey(income),
                                direction: DismissDirection.startToEnd,
                                onDismissed: (direction) {
                                  setState(() {
                                    widget.onDismissedIncome(income);
                                  });
                                },
                                child: IncomeCard(
                                  title: income.title,
                                  date: income.date,
                                  amount: income.amount,
                                  category: income.category,
                                  description: income.description,
                                  time: income.time,
                                ),
                              );
                            },
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
