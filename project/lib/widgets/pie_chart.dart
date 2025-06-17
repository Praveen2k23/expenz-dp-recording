import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project/constant/colors.dart';
import 'package:project/model/expens_model.dart';
import 'package:project/model/income_model.dart';

class Chart extends StatefulWidget {
  final Map<ExpenceCategory, double> epenseCategoryTotals;
  final Map<IncomeCategory, double> incomeCategoryTotals;
  final bool isExpense;

  const Chart({
    super.key,
    required this.epenseCategoryTotals,
    required this.incomeCategoryTotals,
    required this.isExpense,
  });

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<PieChartSectionData> getsection() {
    if (widget.isExpense) {
      return [
        PieChartSectionData(
          color: expenseCategoryColors[ExpenceCategory.food],
          value: widget.epenseCategoryTotals[ExpenceCategory.food] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenceCategory.shopping],
          value: widget.epenseCategoryTotals[ExpenceCategory.shopping] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenceCategory.health],
          value: widget.epenseCategoryTotals[ExpenceCategory.health] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenceCategory.subscriptions],
          value:
              widget.epenseCategoryTotals[ExpenceCategory.subscriptions] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenceCategory.transport],
          value: widget.epenseCategoryTotals[ExpenceCategory.transport] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    } else {
      return [
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.freelance],
          value: widget.incomeCategoryTotals[IncomeCategory.freelance] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.passive],
          value: widget.incomeCategoryTotals[IncomeCategory.passive] ?? 0,
          showTitle: false,
          radius: 60,
        ),

        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.salary],
          value: widget.incomeCategoryTotals[IncomeCategory.salary] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.sales],
          value: widget.incomeCategoryTotals[IncomeCategory.sales] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final PieChartData pieChartData = PieChartData(
      sectionsSpace: 0,
      centerSpaceRadius: 70,
      startDegreeOffset: -90,
      sections: getsection(),
      borderData: FlBorderData(show: false),
    );
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(pieChartData),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "70%",
                style: TextStyle(color: kBlack, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 8),
              Text("of 100%", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
