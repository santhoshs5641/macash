// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:macashh/utility/category_list.dart';
import 'package:macashh/utility/utility.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String selectedCategory = 'Income';

  // Controllers for category input
  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Navigate back when the back icon is pressed
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildInfoContainer(
                      label: 'Income',
                      value: incomes().toString(),
                      color: Colors.green,
                      icon: Icons.arrow_downward,
                    ),
                    buildInfoContainer(
                      label: 'Expense',
                      value: expenses().toString(),
                      color: Colors.red,
                      icon: Icons.arrow_upward,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                buildInfoContainer(
                  label: 'Total Balance',
                  value: total().toString(),
                  color: Colors.green,
                  icon: Icons.task_alt_rounded,
                  width: 180, // Change the width for Total Balance
                ),
                const SizedBox(height: 20),
                const Text(
                  'Add other category',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildCategoryRadio('Income', 'Income'),
                    buildCategoryRadio('Expense', 'Expense'),
                  ],
                ),
                const SizedBox(height: 20),
                if (selectedCategory == 'Income') // Show for Income
                  buildCategorySection(
                    labelText: 'Income Category',
                    hintText: 'Enter Income Category',
                    onAddCategory: addIncomeCategory,
                  ),
                if (selectedCategory == 'Expense') // Show for Expense
                  buildCategorySection(
                    labelText: 'Expense Category',
                    hintText: 'Enter Expense Category',
                    onAddCategory: addExpenseCategory,
                  ),
                const SizedBox(height: 30),
                const Column(
                  children: [
                    Text(
                      'MACASH',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
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

  Widget buildCategoryRadio(String label, String category) {
    return Row(
      children: [
        Radio<String>(
          value: category,
          groupValue: selectedCategory,
          onChanged: (value) {
            setState(() {
              selectedCategory = value!;
            });
          },
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget buildInfoContainer({
    required String label,
    required String value,
    required Color color,
    required IconData icon,
    double width = 130, // Default width
  }) {
    return Container(
      height: 80,
      width: width, // Use the specified width
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 13,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Text(
              '₹ $value',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategorySection({
    required String labelText,
    required String hintText,
    required Function(String) onAddCategory,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            controller: categoryController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              labelText: labelText,
              hintText: hintText,
              labelStyle: TextStyle(
                fontSize: 17,
                color: Colors.grey.shade500,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 2,
                  color: Color(0xffc5c5c5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 2,
                  color: Color(0xffc5c5c5),
                ),
              ),
            ),
          ),
        ),
        ElevatedButton(
          child: const Text(
            'Add category',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            onAddCategory(categoryController.text);
            categoryController.clear(); // Clear the text field
            setState(() {});
          },
        ),
      ],
    );
  }

  // Add income category
  void addIncomeCategory(String category) {
    Categories.addCategory(category, true); // true for income
  }

  // Add expense category
  void addExpenseCategory(String category) {
    Categories.addCategory(category, false); // false for expense
  }

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }
}
