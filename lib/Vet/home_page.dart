import 'package:flutter/material.dart';
import 'package:petcare/Pet Owner//Side_Pages/profile_page.dart';
import 'package:petcare/Pet Owner/Side_Pages/notifications_page.dart';

class VetHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false, // Disable the back button
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.pets),
                    onPressed: () {
                      // Open drawer or navigate to settings
                    },
                  ),
                  Text(
                    'VetCare',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      // Navigate to notifications
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotificationsPage()),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      // Navigate to profile page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              color: Colors.grey[200], // Set background color to grey
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Patient Records',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView( // Wrap the pet cards with SingleChildScrollView
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildPetCard('Fluffy', 'Owner: John Doe', 'Breed: Labrador', () {
                          // Upload medical record for Fluffy
                          // Implement your logic here
                        }),
                        _buildPetCard('Buddy', 'Owner: Jane Smith', 'Breed: Golden Retriever', () {
                          // Upload medical record for Buddy
                          // Implement your logic here
                        }),
                        // Add more pet cards as needed
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Set background color to white
        selectedItemColor: Colors.blueAccent, // Set the selected item color
        unselectedItemColor: Colors.grey, // Set the unselected item color
        currentIndex: 0, // Current index of the selected tab
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Vaccination',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Calendar',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Navigate to records page
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => RecordsPage()),
            // );
          } else if (index == 1) {
            // Navigate to vaccination page
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => VaccinationPage()),
            // );
          } else if (index == 2) {
            // Navigate to calendar page
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => CalendarPage()),
            // );
          }
        },
      ),
    );
  }

  Widget _buildPetCard(String name, String owner, String breed, VoidCallback onPressed) {
    return Card(
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: 200,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                owner,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5),
              Text(
                breed,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  'Upload Medical Record',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
