import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'classifier.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


void main() {
  runApp(MaterialApp(
      home: Home(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
      )));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Classifier classifier = Classifier();
  final picker = ImagePicker();
  String dogBreed = "";
  String dogProb;
  var image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            height: size.height * 0.4,
            width: size.width,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: dogBreed == "" ? AssetImage("assets/mascotitas_logo.png"):
                      FileImage(File(image.path),
                      ),
                  fit: BoxFit.cover,
                )
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.35,
            height: size.height * 0.65,
            width: size.width,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36.0),
                  topRight: Radius.circular(36.0),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    "Raza detectada",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    dogBreed == "" ? "" : "$dogProb% $dogBreed",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          OutlineButton(
                            onPressed: () async {
                              image = await picker.getImage(
                                  source: ImageSource.camera,
                                  maxHeight: 300,
                                  maxWidth: 300,
                                  imageQuality: 100);

                              final outputs =
                                  await classifier.classifyImage(image);

                              setState(() {
                                dogBreed = outputs[0];
                                dogProb = outputs[1];
                              });
                            },
                            highlightedBorderColor: Colors.orange,
                            highlightElevation: 10.0,
                            color: Colors.white,
                            textColor: Colors.white,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.camera_alt,
                              size: 35,
                              color: Colors.orange,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              "Tomar foto",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Column(
                        children: [
                          OutlineButton(
                            onPressed: () async {
                              image = await picker.getImage(
                                source: ImageSource.gallery,
                                maxHeight: 300,
                                maxWidth: 300,
                                imageQuality: 100);

                              final outputs =
                                  await classifier.classifyImage(image);
                              setState(() {
                                dogBreed = outputs[0];
                                dogProb = outputs[1];
                              });
                            },
                            highlightedBorderColor: Colors.blue[800],
                            highlightElevation: 10.0,
                            color: Colors.white,
                            textColor: Colors.white,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.photo,
                              size: 35,
                              color: Colors.blue[800],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:20),
                            child: Text(
                              "Galería",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
