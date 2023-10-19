// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:macashh/utility/Transaction_ListPage.dart';
import 'package:macashh/utility/utility.dart';

class TransactionHistoryRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Recent history',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to the desired page when "See all" is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      // Return the page you want to navigate to
                      return TransactionListPage(
                        box: box,
                      ); // Replace with your page
                    },
                  ),
                );
              },
              child: Text(
                'View all',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
