import 'package:flutter/material.dart';

class MedicalService {
  final String title;
  final String description;

  MedicalService({required this.title, required this.description});
}

class Pet {
  final String name;
  final String breed;
  final String imageUrl;
  final String ownerName;
  final String dob; // Date of birth
  final List<MedicalService> services;

  Pet({
    required this.name,
    required this.breed,
    required this.imageUrl,
    required this.ownerName,
    required this.dob,
    required this.services,
  });
}

class MedicalRecordsPage extends StatelessWidget {
  final List<Pet> pets = [
    Pet(
      name: "Fluffy",
      breed: "Golden Retriever",
      imageUrl: 'assets/images/fluffy.jpg',
      ownerName: "John Doe",
      dob: "2021-04-15",
      services: [
        MedicalService(title: "Blood Test", description: "Routine blood work to check health markers."),
        MedicalService(title: "Radiology", description: "X-ray to check for bone health."),
      ],
    ),
    Pet(
      name: "Rex",
      breed: "German Shepherd",
      imageUrl: 'assets/images/rex.jpg',
      ownerName: "Alice Johnson",
      dob: "2019-08-22",
      services: [
        MedicalService(title: "Scan", description: "Ultrasound scan for internal health."),
        MedicalService(title: "Dental Cleaning", description: "Annual dental cleaning to prevent gum disease."),
      ],
    ),
    Pet(
      name: "Whiskers",
      breed: "Siamese Cat",
      imageUrl: 'assets/images/whiskers.jpg',
      ownerName: "Bob Brown",
      dob: "2020-05-10",
      services: [
        MedicalService(title: "Vaccination", description: "Routine vaccinations for disease prevention."),
        MedicalService(title: "Ear Check", description: "Examination for any signs of infection or mites."),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Records'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return ExpansionTile(
            title: Text(pet.name),
            leading: CircleAvatar(
              backgroundImage: AssetImage(pet.imageUrl), // Using AssetImage for demonstration
            ),
            subtitle: Text('${pet.breed}, Owned by: ${pet.ownerName}, DOB: ${pet.dob}'),
            children: pet.services.map((service) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('${service.title}: ${service.description}', textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.file_upload),
                      label: Text('Upload PDF for ${service.title}'),
                      onPressed: () {
                        // Trigger file upload functionality
                      },
                    ),
                  )
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
