import 'package:flutter/material.dart';
import 'home_page.dart';

class PetsPage extends StatelessWidget {
  const PetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text('Pets'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                // Navigate to notifications
              },
              icon: Icon(Icons.notifications),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Your Pets',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            _buildHorizontalPetList(),
            SizedBox(height: 20),
            _buildVerticalPetCards(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new pet action
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        // Set the background color here
        selectedItemColor: Colors.blueAccent,
        // Set the selected item color
        unselectedItemColor: Colors.grey,
        // Set the unselected item color
        currentIndex: 1,
        // Current index of the selected tab
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
            icon: Icon(Icons.local_hospital),
            label: 'Providers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'To Dos',
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
          }
        },
      ),
    );
  }

  Widget _buildHorizontalPetList() {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2, // Replace with the actual number of pets
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/pet_image.jpg'),
                  child: Icon(Icons.pets), // Default pet icon
                ),
                SizedBox(height: 5),
                Text(
                  'Pet Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _buildVerticalPetCards() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2, // Replace with the actual number of pets
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey, // Placeholder color for pet photo
                  // You can replace the color with an Image.asset widget
                  // containing the actual pet photo
                ),
                SizedBox(height: 20),
                Text(
                  'Pet Name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.transgender), // Icon for gender
                              SizedBox(width: 10),
                              Text('Male'), // Replace with actual gender
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.pets), // Icon for species
                              SizedBox(width: 10),
                              Text('Cat'), // Replace with actual species
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.category), // Icon for breed
                              SizedBox(width: 10),
                              Text('Siamese'), // Replace with actual breed
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.cake), // Icon for birthday
                              SizedBox(width: 10),
                              Text('01/01/2020'), // Replace with actual birthdate
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.scale), // Icon for weight
                              SizedBox(width: 10),
                              Text('5 kg'), // Replace with actual weight
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // View pet profile action
                  },
                  child: Text('View Profile'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}