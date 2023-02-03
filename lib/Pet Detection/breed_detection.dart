import 'dart:io';

import 'package:flutter/material.dart';
import '../classifier.dart';

import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class BreedDetection extends StatefulWidget {
  const BreedDetection({Key key}) : super(key: key);

  @override
  State<BreedDetection> createState() => _BreedDetectionState();
}

class _BreedDetectionState extends State<BreedDetection> {
  final Classifier classifier = Classifier();
  final picker = ImagePicker();
  String dogBreed = "";
  String dogProb = "";
  String url = "";
  var image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 75.0,
              left: 30,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 40,
                    ),
                  ),
                  const Text(
                    "Know me",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 50,
                        fontFamily: "BebasNeue"),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      image = await picker.pickImage(
                          source: ImageSource.camera,
                          maxHeight: 300,
                          maxWidth: 300,
                          imageQuality: 100);

                      final outputs = await classifier.classifyImage(image);

                      setState(() {
                        dogBreed = outputs[0];
                        dogProb = outputs[1];
                      });
                    },
                    child: Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 162, 0, 255),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'Open',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontFamily: "BebasNeue",
                                ),
                              ),
                              TextSpan(
                                text: '\ncamera',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 35,
                                  fontFamily: "BebasNeue",
                                ),
                              ),
                            ])),
                            // child: Text(
                            //   "OPEN\nCAMERA",
                            // style: TextStyle(
                            //   color: Colors.white,
                            //   fontSize: 35,
                            //   fontFamily: "BebasNeue",
                            // ),
                            // ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Icon(
                              Icons.camera_outlined,
                              size: 55,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      image = await picker.pickImage(
                          source: ImageSource.gallery,
                          maxHeight: 300,
                          maxWidth: 300,
                          imageQuality: 100);

                      final outputs = await classifier.classifyImage(image);
                      setState(() {
                        dogBreed = outputs[0];
                        dogProb = outputs[1];
                      });
                    },
                    child: Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.orange,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'Open',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontFamily: "BebasNeue",
                                ),
                              ),
                              TextSpan(
                                text: '\ngallery',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 35,
                                  fontFamily: "BebasNeue",
                                ),
                              ),
                            ])),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Icon(
                              Icons.photo_size_select_actual,
                              size: 55,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
              child: Text(
                dogBreed == "" ? "" : "$dogProb% $dogBreed",
                style: const TextStyle(
                    color: Colors.green, fontSize: 35, fontFamily: "BebasNeue"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
            child: Column(
              children: [
                Container(
                  height: size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueGrey.shade50,
                    image: DecorationImage(
                      image: dogBreed == ""
                          ? AssetImage("assets/images/transparent.png")
                          : FileImage(
                              File(image.path),
                            ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                dogBreed != ""
                    ? GestureDetector(
                        onTap: () async {
                          print('$dogBreed');
                          url = "https://wikipedia.org/wiki/$dogBreed";
                          // if (await canLaunch(url)) {
                          launch(url,
                              forceWebView: true, enableJavaScript: true);
                          // }
                        },
                        child: Container(
                          // height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 10, bottom: 10),
                            child: Row(
                              children: const [
                                Text("click here to know more",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "BebasNeue",
                                        fontSize: 25)),
                                Icon(Icons.keyboard_arrow_right_outlined,
                                    color: Colors.white, size: 40),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
