import 'package:expenses/models/expense.dart' show Expense, categoryIcons;
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({super.key, required this.expense, TextStyle? style});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title),
            const SizedBox(height: 30),
            Row(
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      categoryIcons[expense.category] ?? Icons.help_outline,
                    ),
                    const SizedBox(width: 4),
                    Text(expense.formatedDate()),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
