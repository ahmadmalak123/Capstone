import 'package:flutter/material.dart';
import 'side_pages/add_pet_page.dart';
import '../models/for_pet_owner/pet.dart';
import 'Side_Pages/pet_details_page.dart';
class PetsPage extends StatefulWidget {
  PetsPage({Key? key}) : super(key: key);

  @override
  _PetsPageState createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  List<Pet> pets = [
    Pet(name: 'Milo',
        gender: 'Male',
        species: 'Cat',
        breed: 'Siamese',
        dob: '01/01/2020',
        image: 'assets/milo.jpg'),
    Pet(name: 'Luna',
        gender: 'Female',
        species: 'Dog',
        breed: 'Labrador',
        dob: '02/02/2021',
        image: 'assets/luna.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // No shadow
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
              context, MaterialPageRoute(builder: (context) => AddPetPage()));
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
                  // Background color for the icon
                  backgroundImage: AssetImage(pets[index].image),
                  onBackgroundImageError: (_, __) =>
                      setState(() {
                        pets[index].image =
                        'assets/default_paw_icon.png'; // Default image path when loading fails
                      }),
                  child: pets[index].image == null ? Icon(
                      Icons.pets, size: 50, color: Colors.grey) : null,
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
              MaterialPageRoute(
                  builder: (context) => PetDetailsPage(pet: pets[index])),
            );
          },
          child: Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    pets[index].image,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.pets, size: 100,
                          color: Colors.grey); // Fallback icon
                    },
                  ),
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
                              Icon(Icons.transgender, size: 20,
                                  color: Colors.black54),
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
                              Icon(Icons.category, size: 20,
                                  color: Colors.black54),
                              SizedBox(width: 10),
                              Text('Species: ${pets[index].species}'),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.cake, size: 20, color: Colors.black54),
                              SizedBox(width: 10),
                              Text('DOB: ${pets[index].dob}'),
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
                        MaterialPageRoute(builder: (context) =>
                            PetDetailsPage(pet: pets[index])),
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