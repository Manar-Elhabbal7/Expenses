import 'package:expenses/expenses_list/add_expense.dart';
import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expenses/expenses_list/myexpenses_list.dart';

final List<Expense> allExpenses = [
  Expense(title: 'Education', amount: 31.11, date: DateTime.now(), category: Category.education),
  Expense(title: 'Leisure', amount: 50.8, date: DateTime.now(), category: Category.leisure),
  Expense(title: 'Eating', amount: 40.4, date: DateTime.now(), category: Category.food),
  Expense(title: 'Health', amount: 54.4, date: DateTime.now(), category: Category.health),
  Expense(title: 'Savings', amount: 54.4, date: DateTime.now(), category: Category.savings),
];

class Expenses extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  const Expenses({super.key, required this.onToggleTheme, required this.themeMode});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  void _addExpense(Expense expense) {
    setState(() {
      allExpenses.add(expense);
    });
  }

  void _removeExpense(int index) {
    final removedItem = allExpenses[index];

    setState(() {
      allExpenses.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              allExpenses.insert(index, removedItem);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //the width of height of the screen to make it responsive
    var width = MediaQuery.of(context).size.width;
    var hight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        toolbarHeight: 70,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wallet),
            const SizedBox(width: 9),
            Text(
              'Expenses',
              style: GoogleFonts.ubuntu(
                textStyle: Theme.of(context).textTheme.titleLarge,
                fontSize: 50
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF607d8b),
        leading: IconButton(
          icon: Icon(
            Theme.of(context).brightness == Brightness.dark
                ? Icons.nights_stay
                : Icons.wb_sunny,
            color: Colors.white,
          ),
          onPressed: widget.onToggleTheme,
        ),
      ),

      body: LItem(
        expenses: allExpenses,
        onRemove: _removeExpense,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isDismissible: false,
            context: context,
            builder: (ctx) => AddExpense(onAddExpense: _addExpense),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
