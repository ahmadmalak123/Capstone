import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import '../../models/for_pet_owner/Ownerpet.dart';
import '../../models/for_vet/MedicalRecord.dart';
import 'edit_pet_details_page.dart';

class PetDetailsPage extends StatefulWidget {
  final Pet pet;

  PetDetailsPage({Key? key, required this.pet}) : super(key: key);

  @override
  _PetDetailsPageState createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  late Pet _pet;
  late List<MedicalRecord> medicalRecords;

  @override
  void initState() {
    super.initState();
    _pet = widget.pet;
    medicalRecords = [
      MedicalRecord(
        recordId: 1,
        petId: 1,
        description: "Annual Vaccination",
        service: "Vaccination",
        testResults: null,
        date: DateTime.now().subtract(Duration(days: 60)),
        status: "Pending",
      ),
      MedicalRecord(
        recordId: 2,
        petId: 1,
        description: "Routine Blood Test",
        service: "Blood Test",
        testResults: Uint8List.fromList([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]),
        date: DateTime.now().subtract(Duration(days: 30)),
        status: "Completed",
      ),
    ];
  }

  void _navigateAndDisplayUpdate(BuildContext context) async {
    final updatedPet = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditPetDetailsPage(pet: _pet)),
    );

    if (updatedPet != null) {
      setState(() {
        _pet = updatedPet;
      });
      // Signal the calling page (PetsPage) that an update has occurred
      Navigator.pop(context, updatedPet);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pet.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _navigateAndDisplayUpdate(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                image: _pet.image != null
                    ? DecorationImage(
                  image: MemoryImage(_pet.image!),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
              child: _pet.image == null ? Center(child: Icon(Icons.pets, size: 80, color: Colors.grey[500])) : null,
            ),
            SizedBox(height: 20),
            Text('Name: ${_pet.name}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildDetailRow(Icons.transgender, 'Gender: ${_pet.gender ?? "Unknown"}'),
            _buildDetailRow(Icons.category, 'Species: ${_pet.species ?? "Unknown"}'),
            _buildDetailRow(Icons.pets, 'Breed: ${_pet.breed ?? "Unknown"}'),
            _buildDetailRow(Icons.cake, 'DOB: ${_pet.dob?.toIso8601String().split('T').first ?? "Unknown"}'),
            SizedBox(height: 20),
            Text('Medical Records', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...medicalRecords.map((record) => _buildMedicalRecord(context, record)).toList(),
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
          Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildMedicalRecord(BuildContext context, MedicalRecord record) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(record.description ?? "No Description", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Service: ${record.service ?? "Unknown"}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 4),
            Text("Date: ${record.date?.toIso8601String().split('T').first ?? "Unknown"}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 4),
            Text("Status: ${record.status ?? "Unknown"}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                record.testResults != null ? ElevatedButton(
                  onPressed: () => _downloadPdf(context, record),
                  child: Text('Download'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ) : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadPdf(BuildContext context, MedicalRecord record) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text(record.description ?? "No Description"),
        ),
      ),
    );
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/testResults.pdf');
    await file.writeAsBytes(bytes);

    // Show a snackbar or a dialog after download
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloaded to ${file.path}')),
    );
  }
}
