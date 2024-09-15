import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing/apiCallingTesting/registration_data.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController _textEditingController = new TextEditingController();

  Future<void> sendToServer(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
          Uri.parse('http://localhost:3000/api/data/post'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        print("succefully sendDataToServer");
      } else {
        print('Failed to sendDataToServer');
      }
    } catch (error) {
      print('${error}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _textEditingController,
            ),
            Text('${_textEditingController.text}'),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    Map<String, dynamic> data = {
                      'name': '${_textEditingController.text}'
                    };
                    sendToServer(data);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationData()));
                  });
                },
                child: const Text('registration')),
          ],
        ),
      ),
    );
  }
}