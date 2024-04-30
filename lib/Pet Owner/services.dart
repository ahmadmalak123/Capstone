import 'dart:async';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'pets_page.dart';
import 'petshop_page.dart';
import 'Side_Pages/notifications_page.dart';
import 'calendar.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late final PageController _pageController;
  final _photos = [
    {
      'title': 'Photo 1',
      'description': 'Description 1',
      'imagePath': 'assets/Checkup1.jpeg',
    },
    {
      'title': 'Photo 2',
      'description': 'Description 2',
      'imagePath': 'assets/Checkup2.jpeg',
    },
    {
      'title': 'Photo 3',
      'description': 'Description 3',
      'imagePath': 'assets/Checkup3.jpeg',
    },
    // Add more photos with information as needed
  ];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    // Start auto-scrolling
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < _photos.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Services'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications or perform notification-related action
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'All the services you need!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            _buildAutoScrollPhotoCarousel(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Request an appointment for a:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            _buildServiceCard(context, 'Medication Refill', Icons.medication),
            _buildServiceCard(context, 'Checkup', Icons.medical_services),
            _buildServiceCard(context, 'Trim', Icons.cut),
            _buildServiceCard(context, 'Vaccination', Icons.local_hospital),
            _buildServiceCard(context, 'Surgery', Icons.masks),
            // Add more service cards as needed
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: 3,
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
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Calendar',
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
          } else if (index == 2) {
            // Navigate to pet shop page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PetShopPage()),
            );
          } else if (index == 4) {
            // Navigate to calendar page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarPage()),
            );
          }
          // Add navigation to other pages if needed
        },
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String serviceName, IconData icon) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        leading: Icon(icon),
        title: Text(serviceName),
        onTap: () {
          // Navigate to appointment booking page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppointmentBookingPage(serviceName: serviceName)),
          );
        },
      ),
    );
  }

  Widget _buildAutoScrollPhotoCarousel() {
    return Container(
      height: 350, // Adjust height as needed
      child: PageView.builder(
        controller: _pageController,
        itemCount: _photos.length,
        itemBuilder: (context, index) {
          return _buildPhotoWithInformation(
            _photos[index]['title']!,
            _photos[index]['description']!,
            _photos[index]['imagePath']!,
          );
        },
      ),
    );
  }

  Widget _buildPhotoWithInformation(String title, String description,
      String imagePath) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.black.withOpacity(
                    0.2), // Grey transparent background
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentBookingPage extends StatelessWidget {
  final String serviceName;

  const AppointmentBookingPage({Key? key, required this.serviceName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Service: $serviceName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Select Date:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Action to select date
              },
              child: Text('Select Date'),
            ),
            SizedBox(height: 20),
            Text(
              'Select Vet:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            // Add dropdown or other input for vet selection
            ElevatedButton(
              onPressed: () {
                // Action to select vet
              },
              child: Text('Select Vet'),
            ),
            SizedBox(height: 20),
            Text(
              'Comments:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter comments (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action to confirm appointment booking
              },
              child: Text('Request Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}