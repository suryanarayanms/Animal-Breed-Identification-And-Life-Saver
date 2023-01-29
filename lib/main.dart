import 'package:flutter/material.dart';
import 'package:the_dog_project/homepage.dart';

void main() {
  runApp(
    MaterialApp(
      title: "The Dog Project",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
      ),
    ),
  );
}
