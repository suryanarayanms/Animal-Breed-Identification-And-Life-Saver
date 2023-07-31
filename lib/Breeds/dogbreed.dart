import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Dogs extends StatefulWidget {
  const Dogs({Key key}) : super(key: key);

  @override
  State<Dogs> createState() => _DogsState();
}

class _DogsState extends State<Dogs> {
  List<String> _animals = [];
  String url = "";
  Future<List<String>> _loadAnimals() async {
    List<String> animals = [];
    await rootBundle.loadString('assets/images/Dog/labels.txt').then((q) {
      for (String i in const LineSplitter().convert(q)) {
        animals.add(i);
      }
    });
    return animals;
  }

  @override
  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {
    // Retrieve the questions (Processed in the background)
    List<String> animals = await _loadAnimals();

    // Notify the UI and display the questions
    setState(() {
      _animals = animals;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(),
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
                    'Dog breeds',
                    style: TextStyle(fontFamily: "BebasNeue", fontSize: 50),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20,
              ),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _animals.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 10, bottom: 10),
                      child: GestureDetector(
                        onTap: () async {
                          String name = _animals[index];
                          url = "https://wikipedia.org/wiki/$name";
                          // if (await canLaunch(url)) {
                          launch(url,
                              forceWebView: true, enableJavaScript: true);
                          // }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              top: 20,
                              bottom: 20,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(_animals[index],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: "BebasNeue",
                                      fontSize: 35,
                                      overflow: TextOverflow.fade,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}