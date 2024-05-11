import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/for_pet_owner/pet.dart';
import '../pets_page.dart'; // Assuming this is the path to your PetsPage

class AddPetPage extends StatefulWidget {
  const AddPetPage({Key? key}) : super(key: key);

  @override
  _AddPetPageState createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageData;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageData = bytes;
      });
    }
  }

  void _addPet() {
    DateTime? dob;
    try {
      dob = DateTime.parse(_dobController.text);
    } catch (e) {
      // Handle or log error, maybe show a message that the date format is invalid
      print("Error parsing date: $e");
    }

    // Create the new pet instance
    final newPet = Pet(
      petId: DateTime.now().millisecondsSinceEpoch, // Simple way to generate a unique ID
      ownerId: 1, // Example owner ID, adjust as necessary
      name: _nameController.text,
      species: _speciesController.text,
      breed: _breedController.text,
      gender: _genderController.text,
      dob: dob,
      image: _imageData,
    );

    // Here you would typically add this newPet to your state management system
    // For demonstration, we're just popping back to the previous screen
    Navigator.of(context).pop(newPet);
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
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    image: _imageData != null ? DecorationImage(
                      image: MemoryImage(_imageData!),
                      fit: BoxFit.cover,
                    ) : null,
                  ),
                  child: _imageData == null ? Icon(Icons.photo_camera, size: 50) : null,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Add Pet Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildPetDetailFormField('Name', _nameController),
            _buildPetDetailFormField('Species', _speciesController),
            _buildPetDetailFormField('Gender', _genderController),
            _buildPetDetailFormField('Date of Birth', _dobController),
            _buildPetDetailFormField('Breed', _breedController),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _addPet,
                child: Text('Add Pet'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetDetailFormField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
