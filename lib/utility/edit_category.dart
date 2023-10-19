// ignore_for_file: avoid_print, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class EditCategoryScreen extends StatelessWidget {
  final String initialCategory;

  EditCategoryScreen({required this.initialCategory});

  @override
  Widget build(BuildContext context) {
    TextEditingController categoryController =
        TextEditingController(text: initialCategory);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String updatedCategory = categoryController.text;
                print(
                    'Updated category: $updatedCategory'); // Check if this line is printed
                Navigator.pop(context, updatedCategory);
              },
              child: const Text('Update Category'),
            ),
          ],
        ),
      ),
    );
  }
}
