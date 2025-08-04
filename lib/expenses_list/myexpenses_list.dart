import 'package:expenses/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/expense.dart';

class LItem extends StatelessWidget {
  const LItem({
    super.key,
    required this.expenses,
    required this.onRemove,
  });

  final List<Expense> expenses;
  final void Function(int index) onRemove;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(
            color: Color(0xFF607d8b),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          secondaryBackground: Container(
            color: Color(0xFF607d8b),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) => onRemove(index),
          child: Item(
            expense: expenses[index],
          ),
        ),
      ),
    );
  }
}
