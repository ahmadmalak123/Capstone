import 'package:flutter/material.dart';
class Pet {
  String name;
  String gender;
  String species;
  String breed;
  String dob;
  String image;

  Pet({required this.name, required this.gender, required this.species, required this.breed, required this.dob, required this.image});

  void updateDetails(String name, String gender, String species, String breed, String dob) {
    this.name = name;
    this.gender = gender;
    this.species = species;
    this.breed = breed;
    this.dob = dob;
  }
}
