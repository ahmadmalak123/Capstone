import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../ApiHandler.dart';
import 'package:path/path.dart';


class CreateMedicalRecordPage extends StatefulWidget {
  final int petId;

  const CreateMedicalRecordPage({Key? key, required this.petId}) : super(key: key);

  @override
  _CreateMedicalRecordPageState createState() => _CreateMedicalRecordPageState();
}

class _CreateMedicalRecordPageState extends State<CreateMedicalRecordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();
  DateTime? _dateAdministered;
  String _status = 'Pending';
  File? _testResultsFile;

  Future<void> _pickTestResultsFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _testResultsFile = File(result.files.single.path!);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file selected')),
      );
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Prepare the form data
      var data = {
        'PetId': widget.petId,
        'Description': _descriptionController.text,
        'Service': _serviceController.text,
        'Date': _dateAdministered?.toIso8601String(),
        'Status': _status,
      };

      // Handle file upload separately if a file is selected
      if (_testResultsFile != null) {
        // You may need to adjust this method based on your ApiHandler implementation
        bool fileUploadSuccess = await ApiHandler.uploadFile(_testResultsFile!);
        if (!fileUploadSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to upload file')),
          );
          return;
        }
      }

      // Now submit the form data along with any file path if necessary
      bool success = await ApiHandler().createMedicalRecord(data, _testResultsFile);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Medical record created successfully')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create medical record')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Medical Record for Pet ${widget.petId}'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) => value == null || value.isEmpty ? 'Please enter a description' : null,
            ),
            TextFormField(
              controller: _serviceController,
              decoration: const InputDecoration(labelText: 'Service'),
              validator: (value) => value == null || value.isEmpty ? 'Please enter a service' : null,
            ),
            ListTile(
              title: Text(_dateAdministered == null ? 'Date Administered' : 'Administered On: ${_dateAdministered!.toString().split(' ')[0]}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _dateAdministered ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() => _dateAdministered = picked);
                }
              },
            ),
            ListTile(
              title: const Text('Test Results File'),
              subtitle: _testResultsFile != null ? Text(basename(_testResultsFile!.path)) : const Text('No file selected'),
              trailing: const Icon(Icons.upload_file),
              onTap: _pickTestResultsFile,
            ),
            DropdownButtonFormField<String>(
              value: _status,
              decoration: const InputDecoration(labelText: 'Status'),
              items: ['Pending', 'Complete'].map((status) {
                return DropdownMenuItem(value: status, child: Text(status));
              }).toList(),
              onChanged: (value) => setState(() => _status = value!),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Create'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
