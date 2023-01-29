import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Breeds extends StatefulWidget {
  const Breeds({Key key}) : super(key: key);

  @override
  State<Breeds> createState() => _BreedsState();
}

class _BreedsState extends State<Breeds> {
  List<String> _breeds = [];
  String url = "";
  Future<List<String>> _loadBreeds() async {
    List<String> breeds = [];
    await rootBundle.loadString('assets/labels.txt').then((q) {
      for (String i in const LineSplitter().convert(q)) {
        breeds.add(i);
      }
    });
    return breeds;
  }

  @override
  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {
    // Retrieve the questions (Processed in the background)
    List<String> breeds = await _loadBreeds();

    // Notify the UI and display the questions
    setState(() {
      _breeds = breeds;
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
                    'Breeds',
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
                  itemCount: _breeds.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 10, bottom: 10),
                      child: GestureDetector(
                        onTap: () async {
                          String name = _breeds[index];
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
                                Image.asset(
                                  'assets/images/dog.png',
                                  height: 40,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(_breeds[index],
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
