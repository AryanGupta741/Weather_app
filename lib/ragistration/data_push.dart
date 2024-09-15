import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing/ragistration/data_get.dart';

class DataForm extends StatefulWidget {
  @override
  _DataFormState createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  // TextEditingControllers for text fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _fathersNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Variables for dropdown and radio button values
  String? _selectedGender;
  String? _selectedState;
  String? _selectedBranch;
  String? _selectedDegree;
  int? _selectedYear;

  Future<void> pushData() async {
    print('Full Name: ${_fullNameController.text}');
    print('Father\'s Name: ${_fathersNameController.text}');
    print('Email: ${_emailController.text}');
    print('Phone: ${_phoneController.text}');
    print('Whatsapp: ${_whatsappController.text}');
    print('College: ${_collegeController.text}');
    print('Password: ${_passwordController.text}');
    print('Confirm Password: ${_confirmPasswordController.text}');
    print('Selected Gender: $_selectedGender');
    print('Selected State: $_selectedState');
    print('Selected Branch: $_selectedBranch');
    print('Selected Degree: $_selectedDegree');
    print('Selected Year: $_selectedYear');

    final String fullName = _fullNameController.text;
    final String fatherName = _fathersNameController.text;
    final String emailName = _emailController.text;
    final String phoneName = _phoneController.text;
    final String whatsappName = _whatsappController.text;
    final String collegeName = _collegeController.text;
    final String passwordName = _passwordController.text;
    final response = await http.post(
      Uri.parse('http://13.127.246.196:8000/api/registers/'),
      headers: {
        'Content-Type': 'application/json;  charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "unique": "00000078",
        "full_name": fullName,
        "father_name": fatherName,
        "email": emailName,
        "gender": _selectedGender,
        "date_of_birth": "1995-06-19",
        "phone_number": phoneName,
        "whatsapp_number": whatsappName,
        "college_state": _selectedState,
        "college_name": collegeName,
        "branch_name": _selectedBranch,
        "degree_name": _selectedDegree,
        "passing_year": _selectedYear,
        "password": passwordName,
      }),
    );

    if (response.statusCode == 201) {
      print('Data successfully posted');
      final responseData = json.decode(response.body);
      // print('Parsed Response Data: $responseData');
      // print('Parsed Response Data Type: ${responseData.runtimeType}');
    } else {
      print('Failed to post data. Error: ${response.statusCode}');
      print('Error Body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Personal Information
            Text('Personal Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _fathersNameController,
              decoration: InputDecoration(
                labelText: "Father's Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Male'),
                    leading: Radio<String>(
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Female'),
                    leading: Radio<String>(
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Other'),
                    leading: Radio<String>(
                      value: 'Other',
                      groupValue: _selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedState,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedState = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: 'Birth Place',
                border: OutlineInputBorder(),
              ),
              items: <String>['State 1', 'State 2', 'State 3', 'State 4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Contact Information
            Text('Contact Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _whatsappController,
              decoration: InputDecoration(
                labelText: 'Whatsapp Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Educational Information
            Text('Educational Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: _collegeController,
              decoration: InputDecoration(
                labelText: 'College Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedState,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedState = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: "College's State",
                border: OutlineInputBorder(),
              ),
              items: <String>['State 1', 'State 2', 'State 3', 'State 4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedBranch,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBranch = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: 'Branch',
                border: OutlineInputBorder(),
              ),
              items: <String>['Branch 1', 'Branch 2', 'Branch 3', 'Branch 4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedDegree,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDegree = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: 'Degree',
                border: OutlineInputBorder(),
              ),
              items: <String>['Degree 1', 'Degree 2', 'Degree 3', 'Degree 4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<int>(
              value: _selectedYear,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedYear = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: 'Passout Year',
                border: OutlineInputBorder(),
              ),
              items: <int>[2021, 2022, 2023, 2024] // Replace with actual years
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Password Section
            Text("Let's Create Password",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Handle form submission here
                  await pushData();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DataGet()));
                },
                child: Text('REGISTER'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   // Dispose all the controllers to free up memory
  //   _fullNameController.dispose();
  //   _fathersNameController.dispose();
  //   _emailController.dispose();
  //   _phoneController.dispose();
  //   _whatsappController.dispose();
  //   _collegeController.dispose();
  //   _passwordController.dispose();
  //   _confirmPasswordController.dispose();
  //   super.dispose();
  // }
}
