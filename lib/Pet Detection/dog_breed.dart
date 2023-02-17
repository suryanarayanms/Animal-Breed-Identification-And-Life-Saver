import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:the_dog_project/Pet%20Detection/breed_detection.dart';
import 'package:url_launcher/url_launcher.dart';

class DogBreed extends StatefulWidget {
  final File _image;
  const DogBreed(
    this._image, {
    Key key,
  }) : super(key: key);

  @override
  State<DogBreed> createState() => _DogBreedState();
}

class _DogBreedState extends State<DogBreed> {
  bool _loading = true;
  File _image;
  List _output;

  double probability;

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _output = output;
      _loading = false;
      probability =
          double.parse((_output[0]['confidence'] * 100).toStringAsFixed(2));
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/images/Dog/model_unquant.tflite',
        labels: 'assets/images/Dog/labels.txt');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    {
      _image = widget._image;
      detectImage(_image);

      Size size = MediaQuery.of(context).size;
      return Scaffold(
        backgroundColor: Colors.grey[200],
        body: WillPopScope(
            onWillPop: () async {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => BreedDetection(),
                ),
                (route) => false,
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 75, left: 30),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    BreedDetection(),
                              ),
                              (route) => false,
                            ),
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 40,
                          ),
                        ),
                        const Text(
                          "dog breed",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 50,
                              fontFamily: "BebasNeue"),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(
                    child: Text(
                      _loading
                          ? 'loading...'
                          : probability != ''
                              ? 'It is $probability% a ${_output[0]['label']}'
                              : 's',
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 35,
                          fontFamily: "BebasNeue"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: size.height / 4,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueGrey.shade50,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: _loading
                                  ? AssetImage("assets/images/transparent.png")
                                  : FileImage(
                                      _image,
                                      // width: 160,
                                      // height: 160,
                                      // fit: BoxFit.cover,
                                    )
                              // fit: BoxFit.cover,
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      _loading == false
                          ? GestureDetector(
                              onTap: () {
                                print('$probability ++++++++++');
                                var breed = _output[0]['label'];
                                var url = "https://wikipedia.org/wiki/$breed";
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
            )),
      );
    }
  }
}
