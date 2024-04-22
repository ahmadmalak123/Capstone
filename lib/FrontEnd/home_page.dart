import 'package:flutter/material.dart';
import 'pets_page.dart';
import 'petshop_page.dart';
import 'Side_Pages/profile_page.dart';
import 'Side_Pages/notifications_page.dart';
import 'services.dart';
import 'calendar.dart';

class HomePage extends StatelessWidget {
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
                    'PetCare',
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
                    'Welcome to the home of Pet-Owners!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'How can we help you today?',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView( // Wrap the buttons with SingleChildScrollView
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildMenuButton('Request Appointment'),
                        _buildMenuButton('Contact Provider'),
                        _buildMenuButton('Create To Do'),
                        _buildMenuButton('Review Pet Info'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Placeholder for pet facts with images
            Container(
              color: Colors.grey[200], // Set background color to grey
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  _buildPetFactCard('Fact 1', 'assets/Untitled1.jpeg'),
                  _buildPetFactCard('Fact 2', 'assets/Untitled2.jpeg'),
                  _buildPetFactCard('Fact 3', 'assets/Untitled.jpeg'),
                  // Add more pet fact cards as needed
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Pets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Pet Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Appointments',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Navigate to home page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            // Navigate to pets page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PetsPage()),
            );
          }else if (index == 2) {
            // Navigate to pets page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PetShopPage()),
            );
          } else if (index == 3) {
            // Navigate to providers page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServicesPage()),
            );
          } else if (index == 4) {
            // Navigate to to-dos page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarPage()),
            );
          } /*else if (index == 4) {
            // Navigate to appointments page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppointmentsPage()),
            );
          }*/
        },

      ),
    );
  }

  Widget _buildMenuButton(String title) {
    return ElevatedButton(
      onPressed: () {
        // Implement button functionality
      },
      child: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildPetFactCard(String title, String imagePath) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}