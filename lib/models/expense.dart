import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();  //utility object which now can use anywhere

enum Category{
  Food,
  Travel,
  Leisure,
  Work
}

const categoryIcons = {
  Category.Food : Icons.lunch_dining,
  Category.Travel : Icons.flight_takeoff,
  Category.Leisure : Icons.movie,
  Category.Work : Icons.work,
};

class Expense {
  Expense(
    {
    required this.title, 
    required this.amount, 
    required this.date,
    required this.category,
    }
    ) : id = uuid.v4();

    //for id- I don't want to pass it as an parameter, instead I want to build such a unique id dynamically whenever a new expense object is created- to do that I use third party package(uuid)
  
  final String id;   //unique id
  final String title;
  final double amount;   //1.99
  final DateTime date;   //DateTime built in dart by default
  final Category category; 

  String get formattedDate {
    return formatter.format(date);
  }

}

class ExpenseBucket{
  const ExpenseBucket({
    required this.category, 
  required this.expenses
  });

  ExpenseBucket.forCategory(
    List<Expense> allExpenses, this.category)
     : expenses = allExpenses.where(
      (expense) => expense.category == category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for(final expense in expenses){
      sum += expense.amount;
    }

    return sum;
  }
}

