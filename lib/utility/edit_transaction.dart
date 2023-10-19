// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:macashh/data/model/add_data.dart';
import 'package:hive/hive.dart';

class EditTransactionScreen extends StatefulWidget {
  final Add_data transaction;

  const EditTransactionScreen({Key? key, required this.transaction})
      : super(key: key);

  @override
  _EditTransactionScreenState createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController explainController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  late Box<Add_data> box;
  late DateTime date;
   String? selecteditem1;
    final List<String> _item1 = [
    'Income',
    'Expense',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the current transaction data
    nameController.text = widget.transaction.name;
    explainController.text = widget.transaction.explain;
    amountController.text = widget.transaction.amount;
    selecteditem1 = widget.transaction.IN;
    date = widget.transaction.dateTime;

    // Open the Hive box where your transactions are stored
    Hive.openBox<Add_data>('data').then((value) {
      box = value;
    });
  }

  // void updateTransaction() async {
  //   try {
  //     // Get the updated values from the text controllers
  //     final updatedName = nameController.text;
  //     final updatedExplain = explainController.text;
  //     final updatedAmount = amountController.text;

  //     // Update the retrieved transaction with the new values
  //     widget.transaction.name = updatedName;
  //     widget.transaction.explain = updatedExplain;
  //     widget.transaction.amount = updatedAmount;

  //     // Save the updated transaction back to the Hive box
  //     box.put(widget.transaction.key, widget.transaction);

  //     // Navigate back to the previous screen
  //     Navigator.pop(context);
  //     _showSuccessAlert();
  //   } catch (e) {
  //     print('Error updating transaction: $e');
  //   }
  // }
void updateTransaction() async {
  try {
    // Get the updated values from the text controllers
    final updatedName = nameController.text;
    final updatedExplain = explainController.text;
    final updatedAmount = amountController.text;
    

    // Update the retrieved transaction with the new values
    widget.transaction.name = updatedName;
    widget.transaction.explain = updatedExplain;
    widget.transaction.amount = updatedAmount;
    

    // Update transaction type
    widget.transaction.IN = selecteditem1!;
    widget.transaction.dateTime =date;

    // Save the updated transaction back to the Hive box
    box.put(widget.transaction.key, widget.transaction);

    // Navigate back to the previous screen
    Navigator.pop(context);
    _showSuccessAlert();
  } catch (e) {
    print('Error updating transaction: $e');
  }
}

  void _showSuccessAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Transaction edited successfully'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context); // Close the alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  // void dispose() {
  //   // Close the Hive box when the widget is disposed
  //   box.close();
  //   super.dispose();
  // }

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
      height: 600,
      width: 340,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          transaction_type(),
          const SizedBox(
            height: 30,
          ),
          name(),
          const SizedBox(
            height: 30,
          ),
          explain(),
          const SizedBox(
            height: 30,
          ),
          ammount(),
          const SizedBox(
            height: 30,
          ),
          dateandtime(),
          const SizedBox(
            height: 30,
          ),
          save(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  GestureDetector save() {
    return GestureDetector(
      onTap: () {
        updateTransaction();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,
        ),
        width: 120,
        height: 50,
        child: const Text(
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
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: SizedBox(
      width: 280,
      child: TextField(
        keyboardType: TextInputType.number,
        controller: amountController,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            labelText: 'Amount',
            labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Color(0xffc5c5c5))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Color(0xffc5c5c5)))),
      ),
      ),
    );
  }

  Padding explain() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: SizedBox(
      width: 280,
      child: TextField(
        controller: explainController,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            labelText: 'explain',
            labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Color(0xffc5c5c5))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Color(0xffc5c5c5)))),
      ),
      ),
    );
  }
  Padding name() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: SizedBox(
      width: 280, // Set the desired width here
      child: TextField(
        controller: nameController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          labelText: 'Category',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 2, color: Color(0xffc5c5c5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 2, color: Color(0xffc5c5c5)),
          ),
        ),
      ),
    ),
  );
}


  // Padding name() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(
  //       horizontal: 15,
        
  //     ),
      
  //     child: TextField(
  //       controller: nameController,
  //       decoration: InputDecoration(
  //           contentPadding: const EdgeInsets.symmetric(horizontal: 15),
  //           labelText: 'Category',
  //           labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
  //           enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(10),
  //               borderSide:
  //                   const BorderSide(width: 2, color: Color(0xffc5c5c5))),
  //           focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(10),
  //               borderSide:
  //                   const BorderSide(width: 2, color: Color(0xffc5c5c5)))),
  //     ),
  //   );
  // }
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

  Column background(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: const BoxDecoration(
            color: Color(0xff368983),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
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
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'EDIT',
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
}
