import 'package:flutter/material.dart';
import 'package:turbbbites_flutter_app/views/expenses/expense_model.dart';
import 'package:turbbbites_flutter_app/views/expenses/expenses_list_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: expenses.length,
              itemBuilder: (ctx, index) {
                return Dismissible(
                  key: ValueKey(expenses[index]),
                  onDismissed: (direction) {
                    onRemoveExpense(expenses[index]);
                  },
                  child: ExpensesListItem(expenses[index]),
                );
              }),
        ],
      ),
    );
  }
}
