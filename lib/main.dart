import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_dog_project/homepage.dart'; //For using SystemChrome

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      title: "The Dog Project",
    );
  }
}
