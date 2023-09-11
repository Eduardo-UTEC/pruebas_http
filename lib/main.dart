import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'infrastructure/entities/EmergencyService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prueba html',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Servicios de emergencia'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<EmergencyService> emergencyServicesList = [];

  //Operaciones al iniciar la pagina
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: emergencyServicesList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(emergencyServicesList[index].name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              subtitle: Text(
                  '${emergencyServicesList[index].cityName}, ${emergencyServicesList[index].departmentName}, ${emergencyServicesList[index].countryName}'
              ),
              subtitleTextStyle: const TextStyle(fontSize: 15),
            );
          }),
    );
  }

  Future<void> fetchData() async {
    final url = Uri.http("192.168.1.8:8080", "/emergency_services/findAll/true/URUGUAY");
    var response = await http.get(url);

    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        emergencyServicesList = data.map((item) => EmergencyService.fromJson(item)).toList();
      });
    } else {
      throw Exception('Error al cargar datos desde el servidor');
    }
  }

}


