import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class PostRequest extends StatefulWidget {
  final String name;
  final String phoneNumber;
  const PostRequest({Key key, this.phoneNumber, this.name}) : super(key: key);

  @override
  State<PostRequest> createState() => PostRequestState();
}

class PostRequestState extends State<PostRequest> {
  String location = '';
  String address = 'click here to locate';

  Position position;

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    setState(() {
      address = "locating please wait....";
    });

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // ignore: non_constant_identifier_names
  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  List<String> _issues = [
    'Accident',
    'Injury',
    'Weak',
    'Lost',
    'Other'
  ]; // Option 2
  String _selectedIssue; // Option 2

  String name = '';
  File imageFile;
  XFile imagePath;
  File imagepicked;
  var uploadPath = '';
  final ImagePicker _picker = ImagePicker();
  FirebaseStorage storageRef = FirebaseStorage.instance;

  String collectionName = "issueImages";

  String issue = "";

  String landmark = "";

  String comment = "";

  var selectedIssue = "";

  var currentIssue = "";

  String uploadFileName = "";

  Reference reference;

  UploadTask uploadTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 75.0,
                left: 30,
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => {Navigator.pop(context)},
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                    Text(
                      'make a request',
                      style: TextStyle(fontFamily: "BebasNeue", fontSize: 50),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
              child: Center(child: gallery()),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  // top: 30,
                  left: 30,
                  right: 30.0,
                  bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async => {
                      position = await _getGeoLocationPosition(),
                      location =
                          'Lat: ${position.latitude} , Long: ${position.longitude}',
                      GetAddressFromLatLong(position),
                    },
                    child: TextField(
                      enabled: false,
                      autofocus: false,
                      maxLines: null,
                      autocorrect: false,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "BebasNeue",
                      ),
                      cursorColor: Colors.black,
                      onChanged: (_location) {
                        location = _location;
                      },
                      decoration: InputDecoration(
                          counterText: '',
                          hintText: address,
                          hintStyle: TextStyle(
                              fontFamily: "BebasNeue",
                              fontSize: 20,
                              color: Colors.black45),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        counterText: '',
                        hintText: 'landmark',
                        hintStyle: TextStyle(
                            fontFamily: "BebasNeue",
                            fontSize: 20,
                            color: Colors.black45),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    borderRadius: BorderRadius.circular(12),
                    hint: Text(
                        'Please choose an issue'), // Not necessary for Option 1
                    style: TextStyle(
                        fontFamily: "BebasNeue",
                        fontSize: 20,
                        color: Colors.black),
                    value: _selectedIssue,
                    onChanged: (selectedIssue) {
                      setState(() {
                        currentIssue = selectedIssue;
                        _selectedIssue = selectedIssue;
                      });
                    },
                    items: _issues.map((issue) {
                      return DropdownMenuItem(
                        child: new Text(
                          issue,
                          style:
                              TextStyle(fontFamily: "BebasNeue", fontSize: 20),
                        ),
                        value: issue,
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    autofocus: false,
                    autocorrect: false,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "BebasNeue",
                    ),
                    cursorColor: Colors.black,
                    onChanged: (_comment) {
                      comment = _comment;
                    },
                    decoration: InputDecoration(
                        counterText: '',
                        hintText: 'what happedned ?',
                        hintStyle: TextStyle(
                            fontFamily: "BebasNeue",
                            fontSize: 20,
                            color: Colors.black45),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    autofocus: false,
                    autocorrect: false,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "BebasNeue",
                    ),
                    cursorColor: Colors.black,
                    onChanged: (_landmark) {
                      landmark = _landmark;
                    },
                    decoration: InputDecoration(
                        counterText: '',
                        hintText: 'landmark',
                        hintStyle: TextStyle(
                            fontFamily: "BebasNeue",
                            fontSize: 20,
                            color: Colors.black45),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          if (imagepicked == null &&
                              location == "" &&
                              currentIssue == "" &&
                              comment == "" &&
                              landmark == "")
                            {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isDismissible: false,
                                isScrollControlled: false,
                                builder: (context) {
                                  return Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50.0, left: 20, right: 20),
                                        child: Column(
                                          children: [
                                            Text(
                                              'fill the details first',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontFamily: "BebasNeue",
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20.0),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    {Navigator.pop(context)},
                                                child: Container(
                                                  height: 65,
                                                  decoration: BoxDecoration(
                                                      color: Colors.pink,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Center(
                                                    child: Text(
                                                      "ok",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "BebasNeue",
                                                          fontSize: 25,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            }
                          else if (imagepicked == null)
                            {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isDismissible: false,
                                isScrollControlled: false,
                                builder: (context) {
                                  return Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50.0, left: 20, right: 20),
                                        child: Column(
                                          children: [
                                            Text(
                                              'pick an image',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontFamily: "BebasNeue",
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20.0),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    {Navigator.pop(context)},
                                                child: Container(
                                                  height: 65,
                                                  decoration: BoxDecoration(
                                                      color: Colors.pink,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Center(
                                                    child: Text(
                                                      "ok",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "BebasNeue",
                                                          fontSize: 25,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            }
                          else if (location == "")
                            {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isDismissible: false,
                                isScrollControlled: false,
                                builder: (context) {
                                  return Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50.0, left: 20, right: 20),
                                        child: Column(
                                          children: [
                                            Text(
                                              'choose your location',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontFamily: "BebasNeue",
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20.0),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    {Navigator.pop(context)},
                                                child: Container(
                                                  height: 65,
                                                  decoration: BoxDecoration(
                                                      color: Colors.pink,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Center(
                                                    child: Text(
                                                      "ok",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "BebasNeue",
                                                          fontSize: 25,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            }
                          else if (currentIssue == "")
                            {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isDismissible: false,
                                isScrollControlled: false,
                                builder: (context) {
                                  return Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50.0, left: 20, right: 20),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Select the issue',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontFamily: "BebasNeue",
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20.0),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    {Navigator.pop(context)},
                                                child: Container(
                                                  height: 65,
                                                  decoration: BoxDecoration(
                                                      color: Colors.pink,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Center(
                                                    child: Text(
                                                      "ok",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "BebasNeue",
                                                          fontSize: 25,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            }
                          else if (comment == "")
                            {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isDismissible: false,
                                isScrollControlled: false,
                                builder: (context) {
                                  return Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50.0, left: 20, right: 20),
                                        child: Column(
                                          children: [
                                            Text(
                                              'mention a note',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontFamily: "BebasNeue",
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20.0),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    {Navigator.pop(context)},
                                                child: Container(
                                                  height: 65,
                                                  decoration: BoxDecoration(
                                                      color: Colors.pink,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Center(
                                                    child: Text(
                                                      "ok",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "BebasNeue",
                                                          fontSize: 25,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            }
                          else if (landmark == "")
                            {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isDismissible: false,
                                isScrollControlled: false,
                                builder: (context) {
                                  return Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50.0, left: 20, right: 20),
                                        child: Column(
                                          children: [
                                            Text(
                                              'mention a landmark',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontFamily: "BebasNeue",
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20.0),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    {Navigator.pop(context)},
                                                child: Container(
                                                  height: 65,
                                                  decoration: BoxDecoration(
                                                      color: Colors.pink,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Center(
                                                    child: Text(
                                                      "ok",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "BebasNeue",
                                                          fontSize: 25,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            }
                          else
                            {
                              uploadFileName = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString() +
                                  '.jpg',
                              reference = storageRef
                                  .ref()
                                  .child(collectionName)
                                  .child(uploadFileName),
                              uploadTask =
                                  reference.putFile(File(imagePath.path)),
                              setState(() {
                                imageFile = File(imagePath.path);
                              }),
                              uploadTask.whenComplete(() async {
                                uploadPath = await uploadTask.snapshot.ref
                                    .getDownloadURL();
                                print('uploaded');

                                DocumentReference myDoc = FirebaseFirestore
                                    .instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser.uid)
                                    .collection("my-request")
                                    .doc();

                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser.uid)
                                    .collection("my-request")
                                    .doc(myDoc.id)
                                    .set({
                                  "image": uploadPath,
                                  "location": address,
                                  "issue": currentIssue,
                                  "comment": comment,
                                  "landmark": landmark,
                                  "request-id": myDoc.id,
                                  "uid": FirebaseAuth.instance.currentUser.uid,
                                  "status": "pending",
                                  "latitude": position.latitude,
                                  "longitude": position.longitude,
                                  "name": widget.name,
                                  "phoneNumber": widget.phoneNumber
                                });
                                FirebaseFirestore.instance
                                    .collection("requests")
                                    .doc(myDoc.id)
                                    .set({
                                  "image": uploadPath,
                                  "location": address,
                                  "issue": currentIssue,
                                  "comment": comment,
                                  "landmark": landmark,
                                  "request-id": myDoc.id,
                                  "uid": FirebaseAuth.instance.currentUser.uid,
                                  "status": "pending",
                                  "latitude": position.latitude,
                                  "longitude": position.longitude,
                                  "phoneNumber": widget.phoneNumber
                                });
                              }),
                              Navigator.pop(context)
                            }
                        },
                        child: Container(
                          height: 65,
                          width: 200,
                          // width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 25,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  gallery() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Card(
                color: Color(0xff181A28),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.antiAlias,
                child: imagepicked != null
                    ? GestureDetector(
                        onTap: (() => {imagepicker()}),
                        child: Image.file(
                          imagepicked,
                          width: 215,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                      )
                    : GestureDetector(
                        onTap: (() => {imagepicker()}),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 150,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xff181A28),
                          ),
                          child: const Center(
                            child: Text(
                              'open camera',
                              style: TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 25,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  imagedeleter() {
    setState(() {
      imagepicked = null;
      uploadPath = '';
    });
  }

  imagepicker() async {
    final XFile image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      try {
        final imageFile = File(image.path);
        setState(() {
          imagepicked = imageFile;
        });
      } finally {}

      setState(() {
        imagePath = image;
        imgname = image.name.toString();
      });
    }
  }

  String imgname = '';
}
