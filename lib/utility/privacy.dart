// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text('''
Privacy Policy

Last updated: [Date]

This Privacy Policy describes how MACASH ("we," "our," or "us") collects, uses, and discloses your personal information when you use our mobile application ("App").

1. Information We Collect

1.1 Personal Information

We may collect the following types of personal information when you use our App:
- Financial data (if applicable)

1.2 Usage Data

We also collect non-personal information about your usage of the App, including:
- Device information
- App usage statistics
- Log information

2. How We Use Your Information

We use your personal information for the following purposes:
- To improve and personalize the App

3. Data Security

We take appropriate measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction.

4. Your Choices

You may have the following rights regarding your personal information:
- Access your data
- Correct inaccuracies in your data
- Delete your data
- Object to the processing of your data
- Withdraw consent (if applicable)

5. Contact Us

If you have any questions or concerns about our Privacy Policy, please contact us at [email address].

6. Changes to this Privacy Policy

We may update our Privacy Policy from time to time. The latest version will always be available within the App.

'''),
      ),
    );
  }
}
