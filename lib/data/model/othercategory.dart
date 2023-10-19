// import 'package:hive/hive.dart';

// class DatabaseHelper {
//   static const String _boxName = 'categories';

//   static Box _getBox() {
//     return Hive.box(_boxName);
//   }

//   static void saveIncomeCategory(String category) {
//     var box = _getBox();
//     var categories = box.get('income', defaultValue: <String>[]);

//     categories.add(category);
//     box.put('income', categories);
//   }

//   static void saveExpenseCategory(String category) {
//     var box = _getBox();
//     var categories = box.get('expense', defaultValue: <String>[]);

//     categories.add(category);
//     box.put('expense', categories);
//   }

//   static List<String> getIncomeCategories() {
//     var box = _getBox();
//     return box.get('income', defaultValue: <String>[]);
//   }

//   static List<String> getExpenseCategories() {
//     var box = _getBox();
//     return box.get('expense', defaultValue: <String>[]);
//   }
// }
