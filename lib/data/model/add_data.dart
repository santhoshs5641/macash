// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:hive/hive.dart';

part 'add_data.g.dart';

@HiveType(typeId: 1)
class Add_data extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String explain;
  @HiveField(2)
  String amount;
  @HiveField(3)
  String IN;
  @HiveField(4)
  DateTime dateTime;

  @HiveField(5)
  String? id;

  Add_data(
      this.dateTime, this.IN, this.amount, this.explain, this.name, this.id);

}
