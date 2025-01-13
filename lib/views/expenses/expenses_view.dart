import 'package:flutter/material.dart';
import 'package:turbbbites_flutter_app/views/expenses/expense_form.dart';
import 'package:turbbbites_flutter_app/views/expenses/expense_model.dart';
import 'package:turbbbites_flutter_app/views/expenses/expenses_list.dart';

class ExpensesView extends StatefulWidget {
  const ExpensesView({super.key});

  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> {
  final List<Expense> _registeredExpenses = [
    Expense(
      id: "1",
      title: "JD",
      amount: 20,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      id: "2",
      title: "JDDDDD",
      amount: 22,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpense() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => ExpenseForm(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text("Expense deleted."),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ExpenseTracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpense,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: ExpensesList(
              expenses: _registeredExpenses,
              onRemoveExpense: _removeExpense,
            )),
          )
        ],
      ),
    );
  }
}
