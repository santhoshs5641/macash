// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text('''
Terms and Conditions

Last Updated: [Date]

By using the MACASH mobile application (the "App"), you agree to the following terms and conditions. Please read them carefully.

1. Acceptance of Terms

By using the App, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms, please do not use the App.

2. User Responsibilities

- You are responsible for maintaining the confidentiality of your account credentials.
- You must use the App in compliance with all applicable laws and regulations.
- You may not engage in any unlawful or unauthorized activities on the App.

3. Account Usage

- You must provide accurate and complete information during the registration process.
- You are solely responsible for any activity that occurs under your account.
- We reserve the right to suspend or terminate your account at our discretion.

4. Privacy

- Your use of the App is also governed by our Privacy Policy, which can be found [link to privacy policy].

5. Intellectual Property

- All content and materials provided by the App are protected by copyright and intellectual property laws.
- You may not use, modify, or distribute any content from the App without our written consent.

6. Limitation of Liability

- We are not liable for any damages or losses resulting from your use of the App.
- We make no warranties or representations about the accuracy or reliability of the App's content.

7. Changes to Terms

- We reserve the right to update these terms and conditions at any time.
- You will be notified of any changes, and your continued use of the App constitutes acceptance of the updated terms.

8. Contact Us

If you have any questions or concerns about these terms and conditions, please contact us at [email address].

'''),
      ),
    );
  }
}
