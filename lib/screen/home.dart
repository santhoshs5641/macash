// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:macashh/Screen/add_category.dart';
import 'package:macashh/data/model/add_data.dart';
import 'package:macashh/utility/Head.dart';
import 'package:macashh/utility/bottom_navigation.dart';
import 'package:macashh/utility/transaction.dart';
import 'package:macashh/utility/transaction_history.dart';
import 'package:hive_flutter/adapters.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _Homepage();
}

class _Homepage extends State<Home> {
  int _selectedIndex = 0;

  void _handleTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final box = Hive.box<Add_data>('data');
  // Color statusBarColor = const Color.fromARGB(255, 47, 125, 125);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // ignore: prefer_const_constructors
        child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, value, child) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(height: 340, child: headWidget(context)),
                ),
                TransactionHistoryRow(),
                TransactionListWidget(
                    box: box, scaffoldMessenger: ScaffoldMessenger.of(context)),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onTabChanged: _handleTabChange,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Add_Screen()),
          );
        },
        tooltip: 'Add Category',
        child: const Icon(Icons.add),
      ),
    );
  }
}
