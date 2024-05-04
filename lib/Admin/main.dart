import 'package:flutter/material.dart';
import'manage_page.dart';

void main() {
  runApp(MaterialApp(home: VetManager()));
}

class VetManager extends StatefulWidget {
  @override
  _VetManagerState createState() => _VetManagerState();
}

class _VetManagerState extends State<VetManager> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veterinarian Management'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          VetCard(id: '001', firstName: 'Jane', lastName: 'Doe', email: 'jane.doe@example.com', phoneNumber: '123-456-7890'),
          VetCard(id: '002', firstName: 'John', lastName: 'Smith', email: 'john.smith@example.com', phoneNumber: '234-567-8901'),
          // Add more VetCards here
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateVeterinarianPage()),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[ // Removed const from here
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Management'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class VetCard extends StatelessWidget {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  // Constructor with required fields to avoid null default error
  VetCard({required this.id, required this.firstName, required this.lastName, required this.email, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with actual image URL
        ),
        title: Text('$firstName $lastName'),
        subtitle: Text('Email: $email\nPhone: $phoneNumber'),
        trailing: Text('ID: $id'),
      ),
    );
  }
}