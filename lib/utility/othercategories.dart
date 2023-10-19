// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:macashh/Screen/add_category.dart';
import 'package:macashh/utility/category_list.dart';
import 'package:macashh/utility/edit_category.dart';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<String> incomeCategories = Categories.incomeItems;
  List<String> expenseCategories = Categories.expenseItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Add_Screen()), // Navigate to PieChartWidget
                );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _buildCategorySection('Income Categories', incomeCategories),
          _buildCategorySection('Expense Categories', expenseCategories),
        ],
      ),
    );
  }

  Widget _buildCategorySection(String title, List<String> categories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            String category = categories[index];
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(category),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      String updatedCategory = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditCategoryScreen(initialCategory: category),
                        ),
                      );

                      // Handle the updated category, assuming you are using setState:
                      setState(() {
                        if (incomeCategories.contains(category)) {
                          incomeCategories[incomeCategories.indexOf(category)] =
                              updatedCategory;
                        } else if (expenseCategories.contains(category)) {
                          expenseCategories[expenseCategories
                              .indexOf(category)] = updatedCategory;
                        }
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
