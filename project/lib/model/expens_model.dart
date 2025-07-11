import 'package:flutter/rendering.dart';

enum ExpenceCategory{
  food,
  transport,
  health,
  shopping,
  subscriptions,

}

final Map <ExpenceCategory , String> expenseCategoryImages = {
  ExpenceCategory.food: "assets/images/restaurant.png",
  ExpenceCategory.transport: "assets/images/car.png",
  ExpenceCategory.health: "assets/images/health.png",
  ExpenceCategory.shopping: "assets/images/bag.png",
  ExpenceCategory.subscriptions: "assets/images/bill.png",

};

final Map <ExpenceCategory, Color> expenseCategoryColors = {
  ExpenceCategory.food: const Color(0xFFE57373),
  ExpenceCategory.transport: const Color(0xFF81C784),
  ExpenceCategory.health: const Color(0xFF64B5F6),
  ExpenceCategory.shopping: const Color(0xFFFFD54F),
  ExpenceCategory.subscriptions: const Color(0xFF9575CD),

};

class Expense{
  final int id;
  final String title;
  final double amount;
  final ExpenceCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Expense({required this.id, required this.title, required this.amount, required this.category, required this.date, required this.time, required this.description});


  //Convert the Expens object to a json object 

  Map <String, dynamic> toJSON(){
    return {
      'id' : id,
      'title' : title,
      'amount' : amount,
      'category' : category.index,
      'date' : date.toIso8601String(),
      'time' : time.toIso8601String(),
      'description' : description

    };
  }

  //Create and Expense object from a JSON object
  factory Expense.fromJSON(Map<String, dynamic>json){
    return Expense(
      id: json['id'], 
      title: json['title'], 
      amount: json['amount'], 
      category: ExpenceCategory.values[json['category']], 
      date: DateTime.parse(json['date']) , 
      time: DateTime.parse(json['time']), 
      description: json['description']);
  }

}