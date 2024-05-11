import 'package:flutter/material.dart';
import '../../APiHandler.dart';
import '../../models/for_vet/pet.dart';
import '../../models/for_vet/vaccine.dart';

class VaccinationHistoryPage extends StatefulWidget {
  @override
  _VaccinationHistoryPageState createState() => _VaccinationHistoryPageState();
}

class _VaccinationHistoryPageState extends State<VaccinationHistoryPage> {
  late Future<List<Pet>> _petsFuture;

  @override
  void initState() {
    super.initState();
    _petsFuture = ApiHandler().fetchPets(); // Initialize the future
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vaccination History'),
      ),
      body: FutureBuilder<List<Pet>>(
        future: _petsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load pets: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final pets = snapshot.data!;
            return ListView.builder(
              itemCount: pets.length,
              itemBuilder: (context, index) {
                final pet = pets[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: pet.imageUrl != null
                          ? MemoryImage(pet.imageUrl!)
                          : AssetImage("assets/default_pet.png") as ImageProvider,
                    ),
                    title: Text(pet.name),
                    subtitle: Text("${pet.breed}, owned by ${pet.ownerName}"),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PetVaccinationDetailsPage(pet: pet),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("No pets found"));
          }
        },
      ),
    );
  }
}


class PetVaccinationDetailsPage extends StatelessWidget {
  final Pet pet;

  PetVaccinationDetailsPage({required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${pet.name} Vaccination History'),
      ),
      body: FutureBuilder<List<VaccineRecord>>(
        future: ApiHandler().getAllVaccinationByPetId(pet.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load vaccinations: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final vaccineRecords = snapshot.data!;
            return ListView.builder(
              itemCount: vaccineRecords.length,
              itemBuilder: (context, index) {
                final record = vaccineRecords[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.vaccineName ?? "Unknown Vaccine",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          record.notes ?? "No additional notes",
                          style: const TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Administered On: ${record.dateAdministered?.toString().split(' ')[0] ?? 'Unknown'}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Next Due Date: ${record.nextDueDate?.toString().split(' ')[0] ?? 'Unknown'}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Status: ${record.status ?? 'Unknown'}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("No vaccination records found"));
          }
        },
      ),
    );
  }
}
