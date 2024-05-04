import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class CreateVeterinarianPage extends StatefulWidget {
  @override
  _CreateVeterinarianPageState createState() => _CreateVeterinarianPageState();
}

class _CreateVeterinarianPageState extends State<CreateVeterinarianPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();

  // Attributes
  String username = '';
  String password = '';
  String email = '';
  String firstName = '';
  String lastName = '';
  DateTime? dob;
  String gender = 'Male'; // Default gender
  String specialty = '';
  String workSchedule = '';
  String qualifications = '';
  int yearsExperience = 0;
  String imageUrl = '';

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Veterinarian'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              buildTextField('Username', onChanged: (value) => username = value),
              buildTextField('Password', onChanged: (value) => password = value, obscureText: true),
              buildTextField('Email', onChanged: (value) => email = value),
              buildTextField('First Name', onChanged: (value) => firstName = value),
              buildTextField('Last Name', onChanged: (value) => lastName = value),
              buildDateField(context, 'Date of Birth', _dobController, onChanged: (value) {
                dob = DateFormat('yyyy-MM-dd').parse(value);
              }),
              buildDropdownField('Gender', ['Male', 'Female', 'Other'], onChanged: (value) => gender = value),
              buildTextField('Specialty', onChanged: (value) => specialty = value),
              buildTextField('Work Schedule', onChanged: (value) => workSchedule = value),
              buildTextField('Qualifications', onChanged: (value) => qualifications = value),
              buildTextField('Years of Experience', onChanged: (value) => yearsExperience = int.parse(value), keyboardType: TextInputType.number),
              buildTextField('Image URL', onChanged: (value) => imageUrl = value),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Updated parameter
                  foregroundColor: Colors.white, // Updated parameter
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: _submitForm,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, {required Function(String) onChanged, bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
      ),
    );
  }

  Widget buildDateField(BuildContext context, String label, TextEditingController controller, {required Function(String) onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          suffixIcon: Icon(Icons.calendar_today),
        ),
        onTap: () async {
          FocusScope.of(context).requestFocus(new FocusNode()); // to prevent opening default keyboard
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100));
          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            controller.text = formattedDate; // set output date to TextField value.
            onChanged(formattedDate);
          }
        },
      ),
    );
  }

  Widget buildDropdownField(String label, List<String> items, {required Function(String) onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        value: items.contains(gender) ? gender : null,
        onChanged: (String? newValue) {
          if (newValue != null) onChanged(newValue);
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Here you can handle the data submission to the backend or local storage
      Navigator.pop(context);
    }
  }
}