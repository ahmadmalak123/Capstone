import 'package:flutter/material.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({Key? key}) : super(key: key);

  @override
  _AddPetPageState createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  String _petName = '';
  String _species = '';
  String _gender = '';
  String _dateOfBirth = '';
  String _breed = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Pet'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pet Picture
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: () {
                      // Add action to add pet picture
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Pet Details Form
            Text(
              'Add Pet Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildPetDetailFormField('Name', (value) {
              setState(() {
                _petName = value;
              });
            }),
            _buildPetDetailFormField('Species', (value) {
              setState(() {
                _species = value;
              });
            }),
            _buildPetDetailFormField('Gender', (value) {
              setState(() {
                _gender = value;
              });
            }),
            _buildPetDetailFormField('Date of Birth', (value) {
              setState(() {
                _dateOfBirth = value;
              });
            }),
            _buildPetDetailFormField('Breed', (value) {
              setState(() {
                _breed = value;
              });
            }),
            SizedBox(height: 20),
            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Save new pet details
                  // You can implement the logic here to save the pet details to your database or perform any other action.
                },
                child: Text('Add pet'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetDetailFormField(String label, Function(String) onChanged) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
      ),
      onChanged: onChanged,
    );
  }
}
