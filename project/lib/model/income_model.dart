import 'package:flutter/widgets.dart';

enum IncomeCategory{
  freelance,
  salary,
  passive,
  sales,

}

final Map <IncomeCategory, String> IncomeCategoryImages = {
  IncomeCategory.freelance: "assets/images/freelance.png",
  IncomeCategory.passive: "assets/images/car.png",
  IncomeCategory.salary: "assets/images/health.png",
  IncomeCategory.sales: "assets/images/salary.png",

};


final Map<IncomeCategory, Color> incomeCategoryColors = {
  IncomeCategory.freelance: const Color(0xFFE57373),
  IncomeCategory.passive: const Color(0xFF81C784),
  IncomeCategory.sales: const Color(0xFF64B5F6),
  IncomeCategory.salary: const Color(0xFFFFD54F),
};


final class Income{

  final int id;
  final String title;
  final double amount;
  final IncomeCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Income({required this.id, required this.title, required this.amount, required this.category, required this.date, required this.time, required this.description});


 //Convert the Expens object to a json object 
Map<String, dynamic> toJSON() {
  return {
    'id': id,
    'title': title,
    'amount': amount,
    'category': category.index, 
    'date': date.toIso8601String(),
    'time': time.toIso8601String(),
    'description': description,
  };
}

factory Income.fromJSON(Map<String, dynamic> json) {
  return Income(
    id: json['id'],
    title: json['title'],
    amount: json['amount'],
    category: IncomeCategory.values[json['category']],
    date: DateTime.parse(json['date']),
    time: DateTime.parse(json['time']),
    description: json['description'],
  );
}


}