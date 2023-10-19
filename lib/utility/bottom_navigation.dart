// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, dead_code, unused_label

import 'package:flutter/material.dart';
import 'package:macashh/Screen/graph.dart';
import 'package:macashh/Screen/my_account.dart';
import 'package:macashh/Screen/settings.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const BottomNavigation(
      {required this.selectedIndex, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 20),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          gap: 2,
          tabs: [
            const GButton(
              icon: Icons.home,
              text: 'Home',
              backgroundColor: Colors.white,
            ),
            GButton(
              icon: Icons.auto_graph,
              text: 'Graph',
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Statistics()), // Navigate to PieChartWidget
                );
              },
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            GButton(
              icon: Icons.person,
              text: 'MyAccount',
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
          ],
        ),
      ),
    );
    // floatingActionButton:
    // FloatingActionButton(
    //   backgroundColor: Colors.blue,
    //   onPressed: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => Add_Screen()),
    //     );
    //   },
    //   tooltip: 'Add Category',
    //   child: const Icon(Icons.add),
    // );
  }
}
