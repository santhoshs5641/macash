// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:macashh/data/model/add_data.dart';
import 'package:macashh/utility/edit_transaction.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class TransactionListWidget extends StatelessWidget {
  final Box<Add_data> box;
  final ScaffoldMessengerState scaffoldMessenger;

  const TransactionListWidget({
    super.key,
    required this.box,
    required this.scaffoldMessenger,
  });

  void _showSuccessSnackbar() {
    scaffoldMessenger.showSnackBar(const SnackBar(
      content: Text('Transaction deleted successfully'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final List<Add_data> lastFourItems =
        List<Add_data>.from(box.values.toList().reversed.take(3));

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          
           if (lastFourItems.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              Text('No transactions available.'),
              // You can add additional widgets here if needed
            ],
          ),
        );
      }
          final history = lastFourItems[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              // Handle dismiss (delete) logic here
              box.delete(history.key); // Delete the item from Hive
              _showSuccessSnackbar(); // Show success Snackbar
            },
            child: ListTile(
              title: Text(history.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('E- yyyy-MMM-dd').format(history.dateTime),
                  ),
                  Text(
                    history.explain, // Display the "explain" field
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '₹${history.amount}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: history.IN == 'Income' ? Colors.green : Colors.red,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditTransactionScreen(transaction: history),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        childCount: lastFourItems.isEmpty ? 1 : lastFourItems.length,
      ),
    );
  }
}
