// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:macashh/utility/about.dart';
import 'package:macashh/utility/inivite.dart';
import 'package:macashh/utility/othercategories.dart';
import 'package:macashh/utility/privacy.dart';
import 'package:macashh/utility/terms_condition.dart';

class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Settings Page',
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('About'),
            onTap: () {
              // Navigate to the About page
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => About()));
            },
          ),
          ListTile(
            title: const Text('Invite friends'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InviteFriendPage()));
            },
          ),
          ListTile(
            title: const Text('Privacy'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PrivacyPolicyScreen()));
            },
          ),
          ListTile(
            title: const Text('Terms & Conditions'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TermsAndConditionsScreen()));
            },
          ),
          ListTile(
            title: const Text('Category List'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategoryListPage()));
            },
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const Center(
        child: Text('This is the About page.'),
      ),
    );
  }
}
