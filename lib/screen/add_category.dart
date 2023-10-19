// ignore_for_file: unused_field, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, sort_child_properties_last, non_constant_identifier_names, unnecessary_string_interpolations, avoid_print, unnecessary_null_comparison, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:macashh/data/model/add_data.dart';
import 'package:macashh/utility/category_list.dart';
import 'package:hive/hive.dart';

// ignore: camel_case_types
class Add_Screen extends StatefulWidget {
  const Add_Screen({super.key});

  @override
  State<StatefulWidget> createState() => _AddScreenState();
}

class _AddScreenState extends State<Add_Screen> {
  final box = Hive.box<Add_data>('data');

  DateTime date = DateTime.now();
  String? selecteditem;
  String? selecteditem1;
  final TextEditingController explainC = TextEditingController();
  FocusNode ex = FocusNode();
  final TextEditingController amountC = TextEditingController();
  FocusNode ax = FocusNode();
  final TextEditingController othercategory = TextEditingController();
  // final List<String> _item = [
  //   'Food',
  //   'Transfer',
  //   'Rent',
  //   'Transportation',
  //   'Education',
  // ];
  final List<String> _item1 = [
    'Income',
    'Expense',
  ];
  int currentID = 0;
  @override
  void initState() {
    super.initState();
    selecteditem1 = 'Income';
    ax.addListener(() {
      setState(() {});
    });
    ex.addListener(() {
      setState(() {});
    });
  }

  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Data added successfully'),
      duration: Duration(seconds: 2), // You can adjust the duration as needed
      backgroundColor: Colors.green,
    ));
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            background(context),
            Positioned(
              top: 120,
              child: main_container(),
            ),
          ],
        ),
      ),
    );
  }

  Container main_container() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 550,
      width: 340,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          transaction_type(),
          SizedBox(
            height: 30,
          ),
          explain(),
          SizedBox(
            height: 30,
          ),
          ammount(),
          SizedBox(
            height: 30,
          ),
          category(),
          SizedBox(
            height: 30,
          ),
          dateandtime(),
          Spacer(),
          save(),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  GestureDetector save() {
    return GestureDetector(
      onTap: () {
        if (selecteditem == null) {
          _showErrorDialog('Please select a category.');
          return;
        }
        if (amountC.text.isEmpty) {
          _showErrorDialog('Please enter an amount.');
          return;
        }
        if (explainC.text.isEmpty) {
          _showErrorDialog('Please enter an explanation.');
          return;
        }

        currentID++;
        var add = Add_data(
          date,
          selecteditem1!,
          amountC.text,
          explainC.text,
          selecteditem!,
          currentID.toString(),

          // Assign the ID here
        );

        box.add(add);
        Navigator.of(context).pop();
        _showSuccessSnackbar();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:Colors.blue,
        ),
        width: 120,
        height: 50,
        child: Text(
          'Save',
          style: TextStyle(
            fontFamily: 'f',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Widget dateandtime() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Color(0xffc5c5c5))),
      width: 280,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100));
          if (newDate == null) return;
          setState(() {
            date = newDate;
          });
        },
        child: Text(
          'Date: ${date.year}/ ${date.day} / ${date.month}',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
    );
  }

  Padding transaction_type() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        width: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xffc5c5c5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _item1.map((e) {
            return Row(
              children: [
                Radio<String>(
                  value: e,
                  groupValue: selecteditem1,
                  onChanged: (value) {
                    setState(() {
                      selecteditem1 = value;
                    });
                  },
                ),
                Text(
                  e,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Padding ammount() {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Container(
          width: 280,
          child: TextField(
            keyboardType: TextInputType.number,
            focusNode: ax,
            controller: amountC,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                labelText: 'Amount',
                labelStyle:
                    TextStyle(fontSize: 17, color: Colors.grey.shade500),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 2, color: Color(0xffc5c5c5))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(width: 2, color: Color(0xffc5c5c5)))),
          ),
        ));
  }

  Padding explain() {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Container(
          width: 280,
          child: TextField(
            focusNode: ex,
            controller: explainC,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                labelText: 'explain',
                labelStyle:
                    TextStyle(fontSize: 17, color: Colors.grey.shade500),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 2, color: Color(0xffc5c5c5))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(width: 2, color: Color(0xffc5c5c5)))),
          ),
        ));
  }

  Padding category() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xffc5c5c5),
          ),
        ),
        child: Column(
          children: [
            if (selecteditem1 == 'Income') // Show for Income
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: selecteditem,
                      onChanged: (value) {
                        setState(() {
                          selecteditem = value;
                        });
                      },
                      items: Categories.incomeItems.map((e) {
                        return DropdownMenuItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e as String,
                                style: TextStyle(fontSize: 15),
                              ),
                              // IconButton(
                              //   icon: Icon(Icons.edit),
                              //   onPressed: () async {
                              //     String editedCategory = await Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) =>
                              //             EditCategoryPage(categoryName: e),
                              //       ),
                              //     );

                              //     if (editedCategory != null) {
                              //       // Handle the edited category name
                              //       print('Edited category: $editedCategory');
                              //       // Update your category list with the edited category name
                              //       // ...
                              //     }
                              //   },
                              // ),
                            ],
                          ),
                          value: e,
                        );
                      }).toList(),
                      hint: Text(
                        'Income Category',
                        style: TextStyle(color: Colors.grey),
                      ),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      underline: SizedBox(),
                    ),
                  ),
                  // Add a trailing icon for adding a category
                  InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Container(
                              height: 200,
                              color: Colors.white,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: TextField(
                                        controller: othercategory,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 15,
                                          ),
                                          //labelText: 'Expense Category',
                                          labelStyle: TextStyle(
                                            fontSize: 17,
                                            color: Colors.grey.shade500,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              width: 2,
                                              color: Color(0xffc5c5c5),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              width: 2,
                                              color: Color(0xffc5c5c5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      child: const Text('Add category'),
                                      onPressed: () {
                                        Categories.addCategory(
                                            othercategory.text,
                                            true); // true for income
                                        othercategory
                                            .clear(); // Clear the text field
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Tooltip(
                      message: 'Add other income category',
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            else if (selecteditem1 == 'Expense') // Show for Expense
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: selecteditem,
                      onChanged: (value) {
                        setState(() {
                          selecteditem = value;
                        });
                      },
                      items: Categories.expenseItems.map((e) {
                        return DropdownMenuItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e as String,
                                style: TextStyle(fontSize: 15),
                              ),
                              // IconButton(
                              //   icon: Icon(Icons.edit),
                              //   onPressed: () async {
                              //     // String editedCategory = await Navigator.push(
                              //     //   context,
                              //     //   MaterialPageRoute(
                              //     //     builder: (context) =>
                              //     //         EditCategoryPage(categoryName: e),
                              //     //   ),
                              //     // );

                              //     // if (editedCategory != null) {
                              //     //   // Handle the edited category name
                              //     //   print('Edited category: $editedCategory');
                              //     //   // Update your category list with the edited category name
                              //     //   // ...
                              //     }
                              //   },
                              // ),
                            ],
                          ),
                          value: e,
                        );
                      }).toList(),
                      hint: Text(
                        'Expense Category',
                        style: TextStyle(color: Colors.grey),
                      ),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      underline: SizedBox(),
                    ),
                  ),
                  // Add a trailing icon for adding a category
                  InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Container(
                              height: 200,
                              color: Colors.white,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: TextField(
                                        controller: othercategory,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 15,
                                          ),
                                          labelText: 'Expense Category',
                                          labelStyle: TextStyle(
                                            fontSize: 17,
                                            color: Colors.grey.shade500,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              width: 2,
                                              color: Color(0xffc5c5c5),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              width: 2,
                                              color: Color(0xffc5c5c5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // ... Your existing UI code ...

                                    ElevatedButton(
                                      child: const Text('Add category'),
                                      onPressed: () {
                                        Categories.addCategory(
                                            othercategory.text, false);
                                        othercategory
                                            .clear(); // Clear the text field
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Tooltip(
                      message: 'Add other expense category',
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

Column background(BuildContext context) {
  return Column(
    children: [
      Container(
        width: double.infinity,
        height: 240,
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Adding',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    ],
  );
}
