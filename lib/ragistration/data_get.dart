// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Node Fetch Example',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter Node Fetch Example'),
//         ),
//         body: FetchData(),
//       ),
//     );
//   }
// }

// class FetchData extends StatefulWidget {
//   @override
//   _FetchDataState createState() => _FetchDataState();
// }

// class _FetchDataState extends State<FetchData> {

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
//========================
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataGet extends StatefulWidget {
  const DataGet({super.key});

  @override
  State<DataGet> createState() => _DataGetState();
}

class _DataGetState extends State<DataGet> {
  Map<String, dynamic>? data; // Nullable data variable

  final String id = "4"; // Replace with the actual ID

  @override
  void initState() {
    super.initState();
    fetchData(id); // Fetch data on initialization
  }

  Future<void> fetchData(String id) async {
    try {
      final response = await http.get(Uri.parse('http://13.127.246.196:8000/api/registers/$id'));

      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle any errors that might occur during the fetch
      print('Error fetching data: $e');
      // You can also show a snackbar or any other alert here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Fetch Example'),
      ),
      body: data == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                ListTile(
                  title: Text(data!['full_name']?.toString() ?? 'No Name'),  // Safely access data with a fallback
                ),
              ],
            ),
    );
  }
}

