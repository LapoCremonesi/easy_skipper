import 'dart:async';
import 'dart:convert';

import 'package:easy_skipper/object/barca.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Barche> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('http://192.168.1.100:1337/api/barche?populate=*'));

  if (response.statusCode == 200) {
    return Barche.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load barche');
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Barche> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Barche>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text("larghezza ${snapshot.data!.larghezza}");
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
