import 'package:flutter/material.dart';
import 'appointment_info_page.dart'; // Import the AppointmentInfoPage

class AppointmentHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'APPOINTMENT HISTORY',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildHistoryItem(Icons.calendar_today, 'Appointment 1', 'January 1, 2022', context),
            _buildHistoryItem(Icons.calendar_today, 'Appointment 2', 'February 15, 2022', context),
            _buildHistoryItem(Icons.calendar_today, 'Appointment 3', 'March 30, 2022', context),
            // Add more history items as needed
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(IconData icon, String title, String date, BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the AppointmentInfoPage with the specific appointment details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppointmentInfoPage(
              appointmentTitle: title,
              appointmentDate: date,
              appointmentStatus: 'Scheduled', // Replace with actual appointment status
              appointmentCategory: 'Checkup', // Replace with actual appointment category
              appointmentPet: 'Fluffy', // Replace with actual pet name
              appointmentDescription: 'Description of the appointment', // Replace with actual appointment description
            ),
          ),
        );
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      date,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
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
