// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About MACASH'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to MACASH – Your Ultimate Financial Companion',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Key Features:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            // Separate each feature with its own Text widget
            Text(
              'Expense Tracking: Easily record your daily expenses and keep tabs on your financial health.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Transaction Analysis: Gain insights with detailed transaction categorization and analysis.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Secure & Private: We prioritize your data security and privacy above all else.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Why MACASH?',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'At MACASH, we understand that managing your finances can be challenging. That\'s why we\'ve developed a powerful and user-friendly app to simplify your financial journey. With MACASH, you can take control of your money, save for the future, and achieve your financial aspirations.',
              style: TextStyle(fontSize: 16.0),
            ),
            // Add an explanation of why users should choose MACASH
            // Include images, testimonials, and other content as needed
            SizedBox(height: 16.0),
            Text(
              'Meet the Team:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Our passionate team of developers and financial experts is dedicated to making your financial life easier. We are committed to providing you with the best tools and resources to achieve financial success. ',
              style: TextStyle(fontSize: 16.0),
            ),
            // Introduce your development team and company
            // Include team member photos and descriptions if desired
            SizedBox(height: 16.0),
            // Add more content sections as needed
            Text(
              'Technical Details:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Text('Platforms: Available on iOS and Android.',
                style: TextStyle(fontSize: 16.0)),
            // Add content for section 1
            SizedBox(height: 16.0),
            Text(
              'Download MACASH Today:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Text(
                'Thank you for choosing MACASH to help you achieve financial success. Start your journey today and take control of your finances like never before.',
                style: TextStyle(fontSize: 16.0)),
            // Add content for section 2
            SizedBox(height: 16.0),
            // Continue adding more sections as needed
          ],
        ),
      ),
    );
  }
}
