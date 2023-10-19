// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:share/share.dart';

class InviteFriendPage extends StatelessWidget {
  final TextEditingController friendEmailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  InviteFriendPage({super.key});

  void shareInvitationLink(BuildContext context) {
    // Create a link to your app or a specific page in your app.
    String invitationLink = 'https://yourapp.com/installation'; // Replace with your app's installation link

    // Optionally, include a message entered by the user.
    String message = messageController.text.isNotEmpty
        ? messageController.text
        : 'Check out this amazing app! $invitationLink';

    // Share the link and message using the share package.
    Share.share('$message\n$invitationLink');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invite a Friend'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => shareInvitationLink(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Invite your friend to join MACASH:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: friendEmailController,
              decoration: InputDecoration(labelText: 'Friend\'s Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: messageController,
              decoration: InputDecoration(labelText: 'Your Message'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => shareInvitationLink(context),
              child: Text('Share Invitation Link'),
            ),
          ],
        ),
      ),
    );
  }
}
