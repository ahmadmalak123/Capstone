import 'package:flutter/material.dart';
import '../../models/for_pet_owner/pet.dart';
import 'edit_pet_details_page.dart';

class PetDetailsPage extends StatelessWidget {
  final Pet pet;

  PetDetailsPage({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pet.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditPetDetailsPage(pet: pet)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,  // Fixed height for image container
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[200],  // Light grey color if image fails to load
                  borderRadius: BorderRadius.circular(8),  // Rounded corners for the container
                  image: DecorationImage(
                      image: AssetImage(pet.image),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        // Image loading error handling is silent
                      }
                  )
              ),
              child: pet.image == null || pet.image.isEmpty ? Center(child: Icon(Icons.pets, size: 80, color: Colors.grey[500])) : null,
            ),
            SizedBox(height: 20),
            Text('Name: ${pet.name}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildDetailRow(Icons.transgender, 'Gender: ${pet.gender}'),
            _buildDetailRow(Icons.category, 'Species: ${pet.species}'),
            _buildDetailRow(Icons.pets, 'Breed: ${pet.breed}'),
            _buildDetailRow(Icons.cake, 'DOB: ${pet.dob}'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal, size: 20),
          SizedBox(width: 10),
          Text(text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}