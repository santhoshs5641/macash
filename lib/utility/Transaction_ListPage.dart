// ignore_for_file: file_names, constant_identifier_names, duplicate_ignore, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:macashh/data/model/add_data.dart';
import 'package:macashh/utility/edit_transaction.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class TransactionListPage extends StatefulWidget {
  final Box<Add_data> box;

  const TransactionListPage({super.key, required this.box});

  @override
  // ignore: library_private_types_in_public_api
  _TransactionListPageState createState() => _TransactionListPageState();
}

enum FilterOption {
  All,
  Income,
  Expense,
  // ignore: constant_identifier_names
  Today,
  Yesterday,
  ThisMonth,
  CustomDateRange
  // YearRange
}
class DateRangeFilter {
  DateTime startDate;
  DateTime endDate;

  DateRangeFilter(this.startDate, this.endDate);
}

bool isTransactionWithinDateRange(DateTime transactionDate, DateRangeFilter dateRange) {
  return transactionDate.isAfter(dateRange.startDate) && transactionDate.isBefore(dateRange.endDate);
}
class _TransactionListPageState extends State<TransactionListPage> {
  List<Add_data> filteredTransactions = [];
  TextEditingController searchController = TextEditingController();
  FilterOption selectedFilter = FilterOption.All;

  @override
  void initState() {
    super.initState();
    // Initialize the filtered transactions list with all transactions from the provided box
    filteredTransactions = widget.box.values.toList();
  }

  Future<void> filterTransactions(String query, [DateRangeFilter? dateRange]) async {
     if (selectedFilter == FilterOption.CustomDateRange && dateRange == null) {
    // If selected filter is CustomDateRange and dateRange is not provided, show date picker.
    dateRange = await pickDateRange();
  }
  setState(() {
    filteredTransactions = widget.box.values.where((transaction) {
      final nameMatches =
          transaction.name.toLowerCase().contains(query.toLowerCase());
      final explainMatches =
          transaction.explain.toLowerCase().contains(query.toLowerCase());
          
      final isIncome = transaction.IN == 'Income';
      final isExpense = transaction.IN == 'Expense';

      bool isWithinCustomDateRange = true;
       if (dateRange != null) {
        isWithinCustomDateRange =
            isWithinCustomDateRange && isTransactionWithinDateRange(transaction.dateTime, dateRange);
      }
      switch (selectedFilter) {
        case FilterOption.All:
          return (nameMatches || explainMatches) && isWithinCustomDateRange;
        case FilterOption.Income:
          return (nameMatches || explainMatches) && isIncome && isWithinCustomDateRange;
        case FilterOption.Expense:
          return (nameMatches || explainMatches) && isExpense && isWithinCustomDateRange;
      case FilterOption.Yesterday:
  final yesterday = DateTime.now().subtract(const Duration(days: 1));
  final isTransactionYesterday =
      transaction.dateTime.year == yesterday.year &&
      transaction.dateTime.month == yesterday.month &&
      transaction.dateTime.day == yesterday.day;
  return (nameMatches || explainMatches) &&
         isTransactionYesterday &&
         isWithinCustomDateRange;

        case FilterOption.ThisMonth:
          final startOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
          return (nameMatches || explainMatches) &&
              transaction.dateTime.isAfter(startOfMonth) &&
              isWithinCustomDateRange;
        case FilterOption.Today:
          final now = DateTime.now();
          final startOfDay = DateTime(now.year, now.month, now.day);
          final endOfDay = startOfDay.add(const Duration(days: 1));
          return (nameMatches || explainMatches) &&
              transaction.dateTime.isAfter(startOfDay) &&
              transaction.dateTime.isBefore(endOfDay) &&
              isWithinCustomDateRange;
        case FilterOption.CustomDateRange:
          // Custom date range filtering logic
          return (nameMatches || explainMatches) && isWithinCustomDateRange;
      }
    }).toList();
  });
}
Future<DateRangeFilter?> pickDateRange() async {
  DateTime? startDate;
  DateTime? endDate;

  DateTime? pickedStartDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now().subtract(const Duration(days: 7)), // Initial start date
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
  );

  if (pickedStartDate != null) {
    DateTime? pickedEndDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial end date
      firstDate: pickedStartDate,
      lastDate: DateTime.now(),
    );

    if (pickedEndDate != null) {
      startDate = pickedStartDate;
      endDate = pickedEndDate.add(const Duration(days: 1)); // Include transactions on the end date
    }
  }

  if (startDate != null && endDate != null) {
    return DateRangeFilter(startDate, endDate);
  } else {
    return null;
  }
}


  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Transaction deleted successfully'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        actions: [
          // Add an IconButton for filtering
          PopupMenuButton<FilterOption>(
            icon: const Icon(Icons.filter_list), // Icon for the filter button
            onSelected: (FilterOption result) async {
              
              setState(() {
                selectedFilter = result;
                filterTransactions(searchController.text);
              });
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<FilterOption>>[
              const PopupMenuItem<FilterOption>(
                value: FilterOption.All,
                child: Text('All'),
              ),
              const PopupMenuItem<FilterOption>(
                value: FilterOption.Income,
                child: Text('Income'),
              ),
              const PopupMenuItem<FilterOption>(
                value: FilterOption.Expense,
                child: Text('Expense'),
              ),
              // const PopupMenuItem<FilterOption>(
              //   value: FilterOption.Today,
              //   child: Text('Today'),
              // ),
              // const PopupMenuItem<FilterOption>(
              //   value: FilterOption.Yesterday,
              //   child: Text('Yesterday'),
              // ),
              // const PopupMenuItem<FilterOption>(
              //   value: FilterOption.ThisMonth,
              //   child: Text('This Month'),
              // ),
              // const PopupMenuItem<FilterOption>(
              //   value: FilterOption.YearRange,
              //   child: Text('Year Range'),
              // ),
            ],
          ),
          PopupMenuButton<FilterOption>(
            icon: const Icon(Icons.filter_list), // Icon for the filter button
            onSelected: (FilterOption result) {
              setState(() {
                selectedFilter = result;
                filterTransactions(searchController.text);
              });
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<FilterOption>>[
              const PopupMenuItem<FilterOption>(
                value: FilterOption.Today,
                child: Text('Today'),
              ),
              const PopupMenuItem<FilterOption>(
                value: FilterOption.Yesterday,
                child: Text('Yesterday'),
              ),
              const PopupMenuItem<FilterOption>(
                value: FilterOption.ThisMonth,
                child: Text('This Month'),
              ),
              // const PopupMenuItem<FilterOption>(
              //   value: FilterOption.YearRange,
              //   child: Text('Year Range'),
              // ),
              const PopupMenuItem<FilterOption>(
                value: FilterOption.CustomDateRange,
                child: Text('DateRange'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                filterTransactions(query);
              },
              decoration: const InputDecoration(
                labelText: 'Search Transactions',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
              child:filteredTransactions.isEmpty
          ? const Center(
              child: Text('No transactions available.'),
            ): ListView.builder(
            itemCount: filteredTransactions.length,
            itemBuilder: (context, index) {
              final history = filteredTransactions[index];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  widget.box.delete(history.key);
                  _showSuccessSnackbar();
                },
                child: ListTile(
                  title: Text(history.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('E - yyyy-MMM-dd').format(history.dateTime),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        history.explain,
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
                          color: history.IN == 'Income'
                              ? Colors.green
                              : Colors.red,
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
          )),
        ],
      ),
    );
  }
}
