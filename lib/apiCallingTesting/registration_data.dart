import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationData extends StatefulWidget {
  @override
  State<RegistrationData> createState() => _RegistrationDataState();
}

class _RegistrationDataState extends State<RegistrationData> {
  // const RegistrationData({super.key});
  List<dynamic> data = ['fetch data'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/get'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        data = jsonData['data'];
      });
    } else {
      setState(() {
        data = ['Failed to fetch data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: data.isNotEmpty
          ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext, index) {
                final item = data[index];
                if (item is Map<String, dynamic> && item.containsKey('name')) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Name : ${item['name']}'),
                    ),
                  );
                } else {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text('Invalid item format'),
                    ),
                  );
                }
              })
          : Text('No data available'),
    ));
  }
}