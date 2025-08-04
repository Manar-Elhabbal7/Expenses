import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
//auto generate id
const uuid = Uuid();
final dateFormat = DateFormat.yMd();
enum Category { food, health, leisure, education,savings }
const categoryIcons = {
    Category.education: Icons.school,
    Category.leisure: Icons.movie,
    Category.food: Icons.restaurant,
    Category.health: Icons.local_hospital,
    Category.savings: Icons.savings,
};


class Expense {
    final String id;
    final String title;
    final double amount;
    final DateTime date;
    final Category category;

    String formatedDate(){
      return dateFormat.format(date);
    }

    Expense({
        required this.category,
        required this.title,
        required this.amount,
        required this.date
    }):id = uuid.v4();

}
