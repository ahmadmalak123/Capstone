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
                          : const AssetImage("assets/default_pet.png") as ImageProvider,
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



class PetVaccinationDetailsPage extends StatefulWidget {
  final Pet pet;

  PetVaccinationDetailsPage({required this.pet});

  @override
  _PetVaccinationDetailsPageState createState() => _PetVaccinationDetailsPageState();
}

class _PetVaccinationDetailsPageState extends State<PetVaccinationDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Future<List<VaccineRecord>>? _vaccineRecordsFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _reloadVaccinations();
  }

  void _reloadVaccinations() {
    setState(() {
      _vaccineRecordsFuture =
          ApiHandler().getAllVaccinationByPetId(widget.pet.id);
    });
  }

  Widget _vaccineStatusView(String status) {
    return FutureBuilder<List<VaccineRecord>>(
      future: _vaccineRecordsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text("Failed to load vaccinations: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          List<VaccineRecord> filteredRecords = snapshot.data!.where((
              record) => record.status == status).toList();

          if (filteredRecords.isEmpty) {
            return Center(child: Text("No records for $status vaccinations"));
          }

          return ListView.builder(
            itemCount: filteredRecords.length,
            itemBuilder: (context, index) {
              final VaccineRecord record = filteredRecords[index]; // Here is the definition of record

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
                        "Administered On: ${record.dateAdministered?.toString()
                            .split(' ')[0] ?? 'Unknown'}",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Next Due Date: ${record.nextDueDate?.toString().split(
                            ' ')[0] ?? 'Not Available'}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              bool updated = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateVaccinationPage(
                                      vaccineRecord: record),
                                ),
                              ) ?? false;
                              if (updated) {
                                _reloadVaccinations(); // Call the reload method
                              }
                            },
                            child: Text('Update'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                          ),
                        ],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.pet.name} Vaccination History'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Pending"),
            Tab(text: "Completed"),
            Tab(text: "Missed"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _vaccineStatusView('Pending'),
          _vaccineStatusView('Completed'),
          _vaccineStatusView('Missed'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool updated = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateVaccinationPage(petId: widget.pet.id),
            ),
          ) ?? false;
          if (updated) {
            _reloadVaccinations(); // Refresh the list if a new vaccine record is created
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class CreateVaccinationPage extends StatefulWidget {
  final int petId;

  CreateVaccinationPage({required this.petId});

  @override
  _CreateVaccinationPageState createState() => _CreateVaccinationPageState();
}

class _CreateVaccinationPageState extends State<CreateVaccinationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _vaccineNameController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  DateTime? _dateAdministered;
  DateTime? _nextDueDate;
  String _status = 'Pending';

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'vaccinationId': 0, // Set to 0 for new records
        'petId': widget.petId,
        'vaccineName': _vaccineNameController.text,
        'notes': _notesController.text,
        'dateAdministered': _dateAdministered?.toIso8601String(),
        'nextDueDate': _nextDueDate?.toIso8601String(),
        'status': _status,
      };

      bool success = await ApiHandler().createVaccination(data);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Vaccination record created')));
        Navigator.pop(context, true); // Return true to indicate the list needs refreshing
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create record')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Vaccination Record for ${widget.petId}'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _vaccineNameController,
              decoration: InputDecoration(labelText: 'Vaccine Name'),
              validator: (value) => value!.isEmpty ? 'Please enter a vaccine name' : null,
            ),
            TextFormField(
              controller: _notesController,
              decoration: InputDecoration(labelText: 'Notes'),
            ),
            ListTile(
              title: Text(_dateAdministered == null ? 'Administered Date' : 'Administered On: ${_dateAdministered!.toString().split(' ')[0]}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => _dateAdministered = picked);
              },
            ),
            ListTile(
              title: Text(_nextDueDate == null ? 'Next Due Date' : 'Due On: ${_nextDueDate!.toString().split(' ')[0]}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => _nextDueDate = picked);
              },
            ),
            DropdownButtonFormField<String>(
              value: _status,
              decoration: InputDecoration(labelText: 'Status'),
              items: ['Pending', 'Completed', 'Missed'].map((status) {
                return DropdownMenuItem(value: status, child: Text(status));
              }).toList(),
              onChanged: (value) => setState(() => _status = value!),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Create'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateVaccinationPage extends StatefulWidget {
  final VaccineRecord vaccineRecord;
  UpdateVaccinationPage({required this.vaccineRecord});

  @override
  _UpdateVaccinationPageState createState() => _UpdateVaccinationPageState();
}

class _UpdateVaccinationPageState extends State<UpdateVaccinationPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _vaccineNameController;
  late TextEditingController _notesController;
  DateTime? _dateAdministered;
  DateTime? _nextDueDate;
  late String _status;

  @override
  void initState() {
    super.initState();
    _vaccineNameController = TextEditingController(text: widget.vaccineRecord.vaccineName);
    _notesController = TextEditingController(text: widget.vaccineRecord.notes);
    _dateAdministered = widget.vaccineRecord.dateAdministered;
    _nextDueDate = widget.vaccineRecord.nextDueDate;
    _status = widget.vaccineRecord.status ?? 'Pending';
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'vaccinationId': widget.vaccineRecord.vaccinationId,
        'petId': widget.vaccineRecord.petId,
        'vaccineName': _vaccineNameController.text,
        'notes': _notesController.text,
        'dateAdministered': _dateAdministered?.toIso8601String(),
        'nextDueDate': _nextDueDate?.toIso8601String(),
        'status': _status,
      };

      bool success = await ApiHandler().updateVaccination(widget.vaccineRecord.vaccinationId, data);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Vaccination record updated')));
        Navigator.pop(context, true); // Pop with 'true' to indicate success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update record')));
      }
    }
  }

  Future<void> _deleteRecord() async {
    bool success = await ApiHandler().deleteVaccination(widget.vaccineRecord.vaccinationId);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Vaccination record deleted')));
      Navigator.pop(context, true); // Pop with 'true' to indicate success
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete record')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Vaccination Record'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteRecord,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _vaccineNameController,
              decoration: InputDecoration(labelText: 'Vaccine Name'),
              validator: (value) => value!.isEmpty ? 'Please enter a vaccine name' : null,
            ),
            TextFormField(
              controller: _notesController,
              decoration: InputDecoration(labelText: 'Notes'),
            ),
            ListTile(
              title: Text(_dateAdministered == null ? 'Administered Date' : 'Administered On: ${_dateAdministered!.toString().split(' ')[0]}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _dateAdministered ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => _dateAdministered = picked);
              },
            ),
            ListTile(
              title: Text(_nextDueDate == null ? 'Next Due Date' : 'Due On: ${_nextDueDate!.toString().split(' ')[0]}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _nextDueDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => _nextDueDate = picked);
              },
            ),
            DropdownButtonFormField<String>(
              value: _status,
              decoration: InputDecoration(labelText: 'Status'),
              items: ['Pending', 'Completed', 'Missed'].map((status) {
                return DropdownMenuItem(value: status, child: Text(status));
              }).toList(),
              onChanged: (value) => setState(() => _status = value!),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Update'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
