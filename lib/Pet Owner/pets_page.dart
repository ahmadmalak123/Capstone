import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'pet_page_content/add_pet_page.dart';
import 'pet_page_content/pet_details_page.dart';
import '../models/for_pet_owner/pet.dart'; // Ensure this path is correct

class PetsPage extends StatefulWidget {
  PetsPage({Key? key}) : super(key: key);

  @override
  _PetsPageState createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  List<Pet> pets = [];

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  Future<void> _loadPets() async {
    final miloImage = await _loadImage('assets/milo_OG.jpg');
    final lunaImage = await _loadImage('assets/luna_OG.jpeg');

    final milo = Pet(
      petId: 1,
      ownerId: 1,
      name: 'Milo',
      gender: 'Male',
      species: 'Cat',
      breed: 'Siamese',
      dob: DateTime(2020, 1, 1),
      image: miloImage,
    );
    final luna = Pet(
      petId: 2,
      ownerId: 1,
      name: 'Luna',
      gender: 'Female',
      species: 'Dog',
      breed: 'Labrador',
      dob: DateTime(2021, 2, 2),
      image: lunaImage,
    );

    setState(() {
      pets = [milo, luna];
    });
  }

  Future<Uint8List?> _loadImage(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      return byteData.buffer.asUint8List();
    } catch (e) {
      print('Could not load image $path: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Your Pets',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            _buildHorizontalPetList(),
            _buildVerticalPetCards(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPetPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildHorizontalPetList() {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage:
                  pets[index].image != null ? MemoryImage(pets[index].image!) : null,
                  child: pets[index].image == null
                      ? Icon(Icons.pets, size: 50, color: Colors.grey)
                      : null,
                ),
                SizedBox(height: 5),
                Text(
                  pets[index].name,
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
      itemCount: pets.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PetDetailsPage(pet: pets[index])),
            );
          },
          child: Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  pets[index].image != null
                      ? Image.memory(
                    pets[index].image!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                      : Icon(Icons.pets, size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    pets[index].name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.transgender, size: 20, color: Colors.black54),
                              SizedBox(width: 10),
                              Text('Gender: ${pets[index].gender}'),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.pets, size: 20, color: Colors.black54),
                              SizedBox(width: 10),
                              Text('Breed: ${pets[index].breed}'),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.category, size: 20, color: Colors.black54),
                              SizedBox(width: 10),
                              Text('Species: ${pets[index].species}'),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.cake, size: 20, color: Colors.black54),
                              SizedBox(width: 10),
                              Text('DOB: ${pets[index].dob?.toIso8601String().split('T').first}'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PetDetailsPage(pet: pets[index])),
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
