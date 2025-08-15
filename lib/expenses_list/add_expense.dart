
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}


class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _formatter = DateFormat.yMd();

  Category _selectedCategory = Category.education;
  DateTime? _selectedDate;

  void saveExpense() {
    final title = _titleController.text.trim();
    final amount = _amountController.text.trim();
    final parsedAmount = double.parse(amount);

    if (title.isEmpty ||
        amount.isEmpty ||
        double.tryParse(amount) == null ||
        _selectedDate == null) {
        
        showDialog(
          context: context, 
          barrierDismissible: false,
          builder: (ctx) =>AlertDialog(
            title :const Text('Error occured'),
            content:const Text('Please fill all fields ^_^'),
            actions: [
              
              TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Ok'))
            ],
          )
        );

      return;
    }
    
    widget.onAddExpense(
      Expense(
        title: title,
        amount: parsedAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                TextField(
                  controller: _titleController,
                  maxLength: 30,
                  
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
        
                    labelText: 'Title',
                    hintText: 'Enter title',
                  ),
                ),
                const SizedBox(height: 12),
        
                //  amount and date picker
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        maxLength: 10,
                        
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixText: '\$ ',
                          labelText: 'Amount',
                          hintText: 'Enter amount',
                          
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'Select Date'
                              : _formatter.format(_selectedDate!),
                        ),
                        IconButton(
                          onPressed: _pickDate,
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
        
                // cateogry dropdown button
                DropdownButtonFormField<Category>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category',
                  ),
                  items: Category.values.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
        
                //Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF607d8b),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: saveExpense,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF607d8b),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Save Expense'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
