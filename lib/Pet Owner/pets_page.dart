import 'package:flutter/material.dart';
import 'home_page.dart';
import 'petshop_page.dart';
import 'services.dart';
import 'Side_Pages/notifications_page.dart';
import 'calendar.dart';
import 'Side_Pages/add_pet_page.dart'; // Import the AddPetPage

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
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
            _buildHorizontalPetList(context),
            SizedBox(height: 20),
            _buildVerticalPetCards(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add pet page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPetPage()),
          );
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
            icon: Icon(Icons.shopping_bag),
            label: 'Pet Shop',
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
            // Navigate to pets page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PetShopPage()),
            );
          } else if (index == 3) {
            // Navigate to pets page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServicesPage()),
            );
          } else if (index == 4) {
            // Navigate to pets page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarPage()),
            );
          }
        },
      ),
    );
  }

  Widget _buildHorizontalPetList(BuildContext context) {
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

  Widget _buildVerticalPetCards(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2, // Replace with the actual number of pets
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigate to view and edit pet details page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PetDetailsPage()),
            );
          },
          child: Card(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PetDetailsPage()),
                      );
                    },
                    child: Text('View Profile'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PetDetailsPage extends StatefulWidget {
  @override
  _PetDetailsPageState createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display pet photo
            Container(
              height: 200,
              color: Colors.grey, // Placeholder color for pet photo
              // You can replace the color with an Image.asset widget
              // containing the actual pet photo
            ),
            SizedBox(height: 20),
            _buildDetailField('Pet Name', 'Name'), // Replace 'Name' with actual pet name
            _buildDetailField('Gender', 'Male'), // Replace 'Male' with actual gender
            _buildDetailField('Species', 'Cat'), // Replace 'Cat' with actual species
            _buildDetailField('Breed', 'Siamese'), // Replace 'Siamese' with actual breed
            _buildDetailField('Birthday', '01/01/2020'), // Replace '01/01/2020' with actual birthdate
            _buildDetailField('Weight', '5 kg'), // Replace '5 kg' with actual weight
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to edit pet details page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditPetDetailsPage()),
                );
              },
              child: Text('Edit Details'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class EditPetDetailsPage extends StatefulWidget {
  @override
  _EditPetDetailsPageState createState() => _EditPetDetailsPageState();
}

class _EditPetDetailsPageState extends State<EditPetDetailsPage> {
  // Define controllers for text fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _speciesController = TextEditingController();
  TextEditingController _breedController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pet Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField('Pet Name', _nameController),
            _buildTextField('Gender', _genderController),
            _buildTextField('Species', _speciesController),
            _buildTextField('Breed', _breedController),
            _buildTextField('Birthday', _birthdayController),
            _buildTextField('Weight', _weightController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Update pet details
                _updatePetDetails();
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }

  void _updatePetDetails() {
    // Implement logic to update pet details
    // Retrieve data from controllers
    String name = _nameController.text;
    String gender = _genderController.text;
    String species = _speciesController.text;
    String breed = _breedController.text;
    String birthday = _birthdayController.text;
    String weight = _weightController.text;

    // Update pet details in database or wherever it's stored

    // Navigate back to pet details page
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _genderController.dispose();
    _speciesController.dispose();
    _breedController.dispose();
    _birthdayController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}
