import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:turbbbites_flutter_app/views/expenses/expense_model.dart';

final formatter = DateFormat.yMd();

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, 1, 1);

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExposeDate() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
          useSafeArea: true,
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text("iwanfoieafnnesivn"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text("Close"),
                  )
                ],
              ));
      return;
    }

    widget.onAddExpense(Expense(
        id: "awfdwaf",
        title: _titleController.text.trim(),
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefix: Text("\$"),
                  label: Text("Amount"),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null
                      ? "No date selected"
                      : formatter.format(_selectedDate!)),
                  IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: _presentDatePicker,
                  )
                ],
              )
            ],
          ),
          DropdownButton(
            value: _selectedCategory,
            items: Category.values
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(value.name.toUpperCase()),
                    ))
                .toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }
              setState(() {
                _selectedCategory = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              ElevatedButton(
                onPressed: _submitExposeDate,
                child: const Text('Save expense'),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
