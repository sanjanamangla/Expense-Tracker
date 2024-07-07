import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
//import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
        Expense(
      title: 'Food',
       amount: 15.69, 
       date: DateTime.now(), 
       category: Category.Food,
       ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(  //this fxn will dynamically add a new UI element when it's been executing
    useSafeArea: true,
     isScrollControlled: true,
      context: context, 
      builder: (ctx) =>  NewExpense(_addExpense),
      );
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
          ),
        )
        );
  }

  void _addExpense(Expense expense){
    setState(() {
       _registeredExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text(''));
      if(_registeredExpenses.isNotEmpty){
        mainContent = ExpensesList(
            expenses: _registeredExpenses,
            onRemoveExpense: _removeExpense,
            );
      }

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker',style: TextStyle(fontSize: 23),),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay, 
            icon: Icon(Icons.add),
            ),
        ],
      ),
      body: width < 600 ? Column(
        children: [
        Chart(expenses: _registeredExpenses),
          Expanded(
            child:mainContent
          ),
        ],
      ) : Row(
        children: [
          Expanded(
            child: Chart(expenses: _registeredExpenses),
          ),
          Expanded(
            child:mainContent
          ),
        ],
        ),
    );
  }
}