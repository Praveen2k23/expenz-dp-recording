import 'package:flutter/material.dart';
import 'package:project/constant/colors.dart';
import 'package:project/constant/constants.dart';
import 'package:project/model/expens_model.dart';
import 'package:project/model/income_model.dart';
import 'package:project/widgets/category_card.dart';
import 'package:project/widgets/pie_chart.dart';

class BudgetScreen extends StatefulWidget {
  final Map<ExpenceCategory, double> expenseCategoryTotals;
  final Map<IncomeCategory, double> incomeCategoryTotals;
  const BudgetScreen({
    super.key,
    required this.expenseCategoryTotals,
    required this.incomeCategoryTotals,
  });

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _slectedOption = 0;

  //method to find category color
  Color getCategoryColor(dynamic category) {
    if (category is ExpenceCategory) {
      return expenseCategoryColors[category]!;
    } else {
      return incomeCategoryColors[category]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data =
        _slectedOption == 0
            ? widget.expenseCategoryTotals
            : widget.incomeCategoryTotals;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Finacial Report",
          style: TextStyle(
            fontSize: 18,
            color: kBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefalutPadding / 2),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(color: kBlack.withOpacity(0.1), blurRadius: 20),
                    ],
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _slectedOption = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: _slectedOption == 0 ? kRed : kWhite,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 60,
                            ),
                            child: Text(
                              "Expenses",
                              style: TextStyle(
                                color: _slectedOption == 0 ? kWhite : kBlack,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _slectedOption = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: _slectedOption == 1 ? kGreen : kWhite,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 60,
                            ),
                            child: Text(
                              "Income",
                              style: TextStyle(
                                color: _slectedOption == 1 ? kWhite : kBlack,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Chart(
                epenseCategoryTotals: widget.expenseCategoryTotals,
                incomeCategoryTotals: widget.incomeCategoryTotals,
                isExpense: _slectedOption == 0,
              ),

              SizedBox(height: 20),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final category = data.keys.toList()[index];
                    final total = data.values.toList()[index];
                    return CategoryCard(
                      title: category.name,
                      amount: total,
                      totalAmount: data.values.reduce((value, element) => value + element),
                      progressColor: getCategoryColor(category),
                      isExpense: _slectedOption == 0,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
