// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:macashh/data/model/add_data.dart';
import 'package:macashh/utility/utility.dart';
import 'package:pie_chart/pie_chart.dart';

class Chart extends StatelessWidget {
  final List<Add_data> data;

  Chart({required this.data});

  @override
  Widget build(BuildContext context) {
    // Calculate total income and expenses
    int totalIncome =
        total_chart(data.where((item) => item.IN == 'Income').toList());
    int totalExpenses =
        total_chart(data.where((item) => item.IN == 'Expense').toList());

    // Calculate percentages
    double incomePercentage =
        (totalIncome / (totalIncome + totalExpenses)) * 100;
    double expensesPercentage =
        (totalExpenses / (totalIncome + totalExpenses)) * 100;

    // Data for the pie chart
    Map<String, double> dataMap = {
      'Income': incomePercentage,
      'Expenses': expensesPercentage,
    };

    // Colors for the pie chart sections
    List<Color> colorList = [Colors.green, Colors.red];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: PieChart(
            dataMap: dataMap,
            colorList: colorList,
            animationDuration: const Duration(milliseconds: 800),
            chartRadius: MediaQuery.of(context).size.width / 2.7,
            chartLegendSpacing: 32,
            legendOptions: const LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.bottom,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Display the legend with percentages
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegend(Colors.green,
                "Income (${incomePercentage.toStringAsFixed(2)}%)"),
            const SizedBox(width: 16),
            _buildLegend(Colors.red,
                "Expenses (${expensesPercentage.toStringAsFixed(2)}%)"),
          ],
        ),
      ],
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
