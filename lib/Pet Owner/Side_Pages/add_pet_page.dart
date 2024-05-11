import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({Key? key}) : super(key: key);

  @override
  _AddPetPageState createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  String _petName = '';
  String _species = '';
  String _gender = '';
  String _dateOfBirth = '';
  String _breed = '';

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

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
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                    image: _imageFile == null ? null : DecorationImage(
                      image: FileImage(_imageFile!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: _imageFile == null ? Icon(Icons.photo_camera, size: 50) : null,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Add Pet Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildPetDetailFormField('Name', (value) => _petName = value),
            _buildPetDetailFormField('Species', (value) => _species = value),
            _buildPetDetailFormField('Gender', (value) => _gender = value),
            _buildPetDetailFormField('Date of Birth', (value) => _dateOfBirth = value),
            _buildPetDetailFormField('Breed', (value) => _breed = value),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Placeholder: Here you would typically make an API call to your backend to save the pet details.
                  // Example:
                  // uploadPetDetails(_petName, _species, _gender, _dateOfBirth, _breed, _imageFile);
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
        border: OutlineInputBorder(),  // Add borders to text fields
      ),
      onChanged: onChanged,
    );
  }
}
