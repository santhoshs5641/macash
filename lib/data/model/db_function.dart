// import 'package:flutter_application_1/data/model/add_data.dart';
// import 'package:hive_flutter/adapters.dart';

// class DatabaseHelper {
//   late Box<Add_data> _box;

//   DatabaseHelper() {
//     initHive();
//   }

//   Future<void> initHive() async {
//     await Hive.initFlutter();
//     Hive.registerAdapter(AdddataAdapter());
//     _box = await Hive.openBox<Add_data>('data');
//   }

//   Future<void> openBox() async {
//     _box = await Hive.openBox<Add_data>('data');
//   }

//   Future<void> addTransaction(Add_data transaction) async {
//     await _box.add(transaction);
//   }

//   Future<List<Add_data>> getAllTransactions() async {
//     return _box.values.toList();
//   }

//   Future<void> updateTransaction(String key, Add_data transaction) async {
//     await _box.put(key, transaction);
//   }

//   Future<void> deleteTransaction(int key) async {
//     await _box.delete(key);
//   }

//   Future<void> closeBox() async {
//     await _box.close();
//   }
// }
