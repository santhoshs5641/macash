// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:macashh/data/model/add_data.dart';
import 'package:macashh/utility/Pie_graph.dart';
import 'package:macashh/utility/utility.dart';
import 'package:intl/intl.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

ValueNotifier<int> selectedIndex = ValueNotifier(0); // Create the ValueNotifier

class _StatisticsState extends State<Statistics> {
  List day = ['Day', 'Week', 'Month', 'Year'];
  List f = [today(), Week(), month(), year()];
  List<Add_data> a = [];
  int index_color = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Add the AppBar with a back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back when the button is pressed
          },
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndex, // Pass the ValueNotifier here
          builder: (BuildContext context, int value, Widget? child) {
            a = f[value];
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Statistics',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ...List.generate(
                              4,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      index_color = index;
                                      selectedIndex.value = index;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: index_color == index
                                          ? const Color.fromARGB(
                                              255, 47, 125, 121)
                                          : Colors.white,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      day[index],
                                      style: TextStyle(
                                          color: index_color == index
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Chart(data: a),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transactions',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.swap_vert,
                              size: 25,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ListTile(
                        // leading: ClipRRect(
                        //   borderRadius: BorderRadius.circular(5),
                        //   // child: Image.asset(
                        //   //   'images/${a[index].name}.png}',
                        //   //   height: 40,
                        //   // ),
                        // ),
                        title: Text(
                          a[index].name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          '${DateFormat.MMM().format(a[index].dateTime)} ${a[index].dateTime.day}-${a[index].dateTime.year}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        //   //'${day[a[index].dataTime.weekday - 1]}${a[index].dataTime.year}-${a[index].dataTime.day}-${a[index].dataTime.month}',
                        //   ' ${a[index].dateTime.year}-${a[index].dateTime.day}-${a[index].dateTime.month}',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                        trailing: Text(
                          ' ₹${a[index].amount}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: a[index].IN == 'Income'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      );
                    },
                    childCount: a.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
