import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import '../../models/for_pet_owner/pet.dart';

class EditPetDetailsPage extends StatefulWidget {
  final Pet pet;

  EditPetDetailsPage({Key? key, required this.pet}) : super(key: key);

  @override
  _EditPetDetailsPageState createState() => _EditPetDetailsPageState();
}

class _EditPetDetailsPageState extends State<EditPetDetailsPage> {
  late TextEditingController _nameController;
  late TextEditingController _genderController;
  late TextEditingController _speciesController;
  late TextEditingController _breedController;
  late TextEditingController _dobController;
  Uint8List? _imageData;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pet.name);
    _genderController = TextEditingController(text: widget.pet.gender);
    _speciesController = TextEditingController(text: widget.pet.species);
    _breedController = TextEditingController(text: widget.pet.breed);
    _dobController = TextEditingController(text: widget.pet.dob?.toIso8601String().split('T').first);
    _imageData = widget.pet.image;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _speciesController.dispose();
    _breedController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _updatePetDetails() {
    // Placeholder for API call to update pet details on the backend
    Navigator.pop(context);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageData = File(pickedFile.path).readAsBytesSync();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.pet.name}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[200], // Default background color
                  backgroundImage: _imageData != null
                      ? MemoryImage(_imageData!) as ImageProvider<Object>
                      : AssetImage('assets/default_image.png') as ImageProvider<Object>,
                  child: _imageData == null ? Icon(Icons.camera_alt, color: Colors.white70, size: 30) : null,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _genderController,
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              TextField(
                controller: _speciesController,
                decoration: InputDecoration(labelText: 'Species'),
              ),
              TextField(
                controller: _breedController,
                decoration: InputDecoration(labelText: 'Breed'),
              ),
              TextField(
                controller: _dobController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode()); // to prevent opening default keyboard
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: widget.pet.dob ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    _dobController.text = pickedDate.toIso8601String().split('T').first; // Update text field
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updatePetDetails,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
