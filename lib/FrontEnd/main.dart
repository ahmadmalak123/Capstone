import 'package:flutter/material.dart';
import 'home_page.dart';
import 'pets_page.dart';
import 'petshop_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetCare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        // '/pets': (context) => PetsPage(),
        // '/Pet Shop': (context) => PetShopPage(),
      },
    );
  }
}
