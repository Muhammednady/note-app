import 'package:flutter/material.dart';
import 'package:noteappdb/addnote.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        
      ),

     routes: {
              "home":(context) => Home(),
              "addnote":(context) => AddNote(),
             },
      home: Home(),
    );
  }
}
     