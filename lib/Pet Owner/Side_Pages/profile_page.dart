import 'package:flutter/material.dart';
import 'notifications_settings_page.dart';
import 'appointment_history_page.dart';
import 'help_center_page.dart'; // Import the Help Center page
import 'privacy_policy_page.dart'; // Import the Privacy Policy page
import 'terms_of_use_page.dart'; // Import the Terms of Use page

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'MY PROFILE',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildProfileCard(),
            SizedBox(height: 20),
            _buildProfileRow(Icons.notifications, 'Notification Settings', context),
            _buildProfileRow(Icons.calendar_today, 'Appointment History', context),
            _buildProfileRow(Icons.help_outline, 'Help Center', context),
            _buildProfileRow(Icons.lock_outline, 'Privacy Policy', context),
            _buildProfileRow(Icons.description, 'Terms of Use', context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              // Placeholder for profile pic
              backgroundColor: Colors.grey,
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'john.doe@example.com',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                Text(
                  '+1234567890',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(IconData icon, String title, BuildContext context) {
    return InkWell(
      onTap: () {
        if (title == 'Notification Settings') {
          // Navigate to notification settings page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationSettingsPage()),
          );
        } else if (title == 'Appointment History') {
          // Navigate to appointment history page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppointmentHistoryPage()),
          );
        } else if (title == 'Help Center') {
          // Navigate to help center page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HelpCenterPage()),
          );
        } else if (title == 'Privacy Policy') {
          // Navigate to privacy policy page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
          );
        } else if (title == 'Terms of Use') {
          // Navigate to terms of use page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TermsOfUsePage()),
          );
        } else {
          // Navigate to respective page (other options)
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Icon(Icons.navigate_next),
          ],
        ),
      ),
    );
  }
}

