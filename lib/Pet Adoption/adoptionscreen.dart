import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:the_dog_project/Pet%20Adoption/auth_service.dart';
import 'package:the_dog_project/Pet%20Adoption/post_request.dart';
import 'package:the_dog_project/Pet%20Adoption/theme.dart';
import 'package:the_dog_project/Pet%20Adoption/view_request.dart';
import 'package:the_dog_project/homepage.dart';

class AdoptionScreen extends StatefulWidget {
  const AdoptionScreen({Key key}) : super(key: key);

  @override
  State<AdoptionScreen> createState() => _AdoptionScreenState();
}

class _AdoptionScreenState extends State<AdoptionScreen> {
  String name = "";
  String mobileNumber = "";
  File imageFile;
  XFile imagePath;
  File imagepicked;
  String number = "";
  var uploadPath = '';
  final ImagePicker picker = ImagePicker();
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String collectionName = "trendingtemplates";

  String phoneNumber = "";

  var reqID = "";

  var location;

  var landmark;
  var comment;
  var issue;
  var imageurl;

  var status;

  var note;

  var statusImage;
  Future<void> retrieveData() async {
    number = context.watch<TemporaryData>().phoneNumber;
  }

  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('my-request');

  @override
  Widget build(BuildContext context) {
    retrieveData();
    return (context.watch<TemporaryData>().phoneNumber == "")
        ? Scaffold(
            backgroundColor: Colors.grey[200],
            body: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 35.0,
                      bottom: 50,
                    ),
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
                          'FILL ME',
                          style:
                              TextStyle(fontFamily: "BebasNeue", fontSize: 50),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    autofocus: false,
                    keyboardType: TextInputType.name,
                    maxLength: 15,
                    autocorrect: false,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "BebasNeue",
                    ),
                    cursorColor: Colors.black,
                    onChanged: (_name) {
                      name = _name;
                    },
                    decoration: InputDecoration(
                        counterText: '',
                        hintText: 'name',
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
                  TextField(
                    autofocus: false,
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "BebasNeue",
                    ),
                    cursorColor: Colors.black,
                    maxLength: 10,
                    onChanged: (_mobileNumber) {
                      mobileNumber = _mobileNumber;
                    },
                    decoration: InputDecoration(
                        hintText: 'Phone number',
                        counterText: '',
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
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () => {
                      if (name == null && mobileNumber == null)
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
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50.0, left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          'enter name and mobile number',
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
                                                      fontFamily: "BebasNeue",
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
                      else if (name != null && mobileNumber == null)
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
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50.0, left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          'enter mobile number',
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
                                                      fontFamily: "BebasNeue",
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
                      else if (name == null && mobileNumber != null)
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
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50.0, left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          'enter name',
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
                                                      fontFamily: "BebasNeue",
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
                      else if (mobileNumber.length < 10)
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
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50.0, left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          'enter 10 dight mobile number',
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
                                                      fontFamily: "BebasNeue",
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
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .update({
                            "phoneNumber": mobileNumber,
                            "name": name,
                          }),
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AdoptionScreen(),
                            ),
                            (route) => false,
                          )
                        }
                    },
                    child: Container(
                      height: 65,
                      width: MediaQuery.of(context).size.width,
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
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.grey[200],
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(25.0),
              child: FloatingActionButton(
                child: Icon(Icons.add_outlined),
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostRequest()))
                },
              ),
              // child: Container(
              //   // height: 30,
              //   // width: 30,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     color: Colors.pink,
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(
              //       "POST REQUEST",
              //       style: TextStyle(
              //           fontFamily: "BebasNeue",
              //           fontSize: 25,
              //           color: Colors.white),
              //     ),
              //   ),
              // ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 35.0,
                      bottom: 30,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => HomePage(),
                              ),
                              (route) => false,
                            )
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 50,
                          ),
                        ),
                        Text(
                          'my requests',
                          style:
                              TextStyle(fontFamily: "BebasNeue", fontSize: 50),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => {
                            AuthService().signOut(),

                            // context.read<TemporaryData>().cleanData(),
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) => HomePage(),
                            // ),
                            // (route) => false,
                            // )
                          },
                          child: Image.asset(
                            "assets/images/shutdown.png",
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: StreamBuilder(
                        stream: ref.snapshots(),
                        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data?.docs?.length != 0) {
                              return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.all(10),
                                itemCount: snapshot.data?.docs?.length,
                                itemBuilder: ((context, index) {
                                  dynamic doc =
                                      snapshot.data?.docs[index].data();
                                  return Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Container(
                                          // height: 200,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              color: doc['status'] == "secured"
                                                  ? Colors.green
                                                  : doc['status'] == "active"
                                                      ? Colors.orange
                                                      : Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0,
                                                top: 20,
                                                bottom: 20,
                                                right: 140),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      color: doc['status'] ==
                                                              "secured"
                                                          ? Colors.white
                                                          : doc['status'] ==
                                                                  "active"
                                                              ? Colors.white
                                                              : Colors.blueGrey
                                                                  .shade50,
                                                      child: doc['status'] ==
                                                              "secured"
                                                          ? Image.network(
                                                              doc['status_image'],
                                                              width: 125,
                                                              height: 125,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Image.network(
                                                              doc['image'],
                                                              width: 125,
                                                              height: 125,
                                                              fit: BoxFit.cover,
                                                            ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              "issue:  " +
                                                                  doc['issue'],
                                                              style: TextStyle(
                                                                  color: doc['status'] ==
                                                                          "secured"
                                                                      ? Colors
                                                                          .white
                                                                      : doc['status'] ==
                                                                              "active"
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black,
                                                                  fontFamily:
                                                                      "BebasNeue",
                                                                  fontSize:
                                                                      20)),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0,
                                                                  right: 8.0,
                                                                  bottom: 8.0),
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  children: [
                                                                TextSpan(
                                                                  text: "note: \n" +
                                                                      doc["comment"],
                                                                  style:
                                                                      TextStyle(
                                                                    color: doc['status'] ==
                                                                            "secured"
                                                                        ? Colors
                                                                            .white
                                                                        : doc['status'] ==
                                                                                "active"
                                                                            ? Colors.white
                                                                            : Colors.black,
                                                                    fontSize:
                                                                        20,
                                                                    fontFamily:
                                                                        "BebasNeue",
                                                                  ),
                                                                ),
                                                              ])),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0,
                                                                  right: 8.0,
                                                                  bottom: 8.0),
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  children: [
                                                                TextSpan(
                                                                  text: "location:  \n" +
                                                                      doc["location"],
                                                                  style:
                                                                      TextStyle(
                                                                    color: doc['status'] ==
                                                                            "secured"
                                                                        ? Colors
                                                                            .white
                                                                        : doc['status'] ==
                                                                                "active"
                                                                            ? Colors.white
                                                                            : Colors.black,
                                                                    fontSize:
                                                                        20,
                                                                    fontFamily:
                                                                        "BebasNeue",
                                                                  ),
                                                                ),
                                                              ])),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () => {
                                                    reqID = doc['request-id'],
                                                    location = doc['location'],
                                                    landmark = doc['landmark'],
                                                    comment = doc['comment'],
                                                    imageurl = doc['image'],
                                                    issue = doc['issue'],
                                                    status = doc['status'],
                                                    note = doc['note'],
                                                    statusImage =
                                                        doc['status_image'],
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Viewrequest(
                                                                    status:
                                                                        status,
                                                                    reqID:
                                                                        reqID,
                                                                    location:
                                                                        location,
                                                                    landmark:
                                                                        landmark,
                                                                    comment:
                                                                        comment,
                                                                    imageurl:
                                                                        imageurl,
                                                                    issue:
                                                                        issue,
                                                                    note: note,
                                                                    statusImage:
                                                                        statusImage)))
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      // height: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          color: doc['status'] ==
                                                                  "secured"
                                                              ? Color.fromARGB(
                                                                      255,
                                                                      31,
                                                                      110,
                                                                      34)
                                                                  .withOpacity(
                                                                      0.5)
                                                              : doc['status'] ==
                                                                      "active"
                                                                  ? Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          135,
                                                                          25)
                                                                  : Colors.grey
                                                                      .withOpacity(
                                                                          0.2)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0,
                                                                top: 10,
                                                                bottom: 10),
                                                        child: Row(
                                                          children: [
                                                            Text('click here',
                                                                style: TextStyle(
                                                                    color: doc['status'] == "secured"
                                                                        ? Colors.white
                                                                        : doc['status'] == "active"
                                                                            ? Colors.white
                                                                            : Colors.black,
                                                                    fontFamily: "BebasNeue",
                                                                    fontSize: 25)),
                                                            Icon(
                                                                Icons
                                                                    .keyboard_arrow_right_outlined,
                                                                color: doc['status'] ==
                                                                        "secured"
                                                                    ? Colors
                                                                        .white
                                                                    : doc['status'] ==
                                                                            "active"
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                size: 40),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              );
                            } else {
                              return Center(
                                  child: Text("No request's submitted",
                                      style: TextStyle(
                                          color: Colors.black38,
                                          fontFamily: "BebasNeue",
                                          fontSize: 25)));
                            }
                          } else {
                            return Center(
                              child: Text("No request's submitted",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontFamily: "BebasNeue",
                                      fontSize: 25)),
                            );
                          }
                        }),
                    // child: StreamBuilder<QuerySnapshot>(
                    //     stream: FirebaseFirestore.instance
                    //         .collection('users').doc(id).collection()
                    //         .snapshots(),
                    //     builder: (context, snapshots) {
                    //       return ListView.builder(
                    //         physics: const BouncingScrollPhysics(),
                    //         itemCount: snapshots.data.docs.length,
                    //         itemBuilder: ((context, index) {
                    //           int a = snapshots.data.docs.length;
                    //           var data = snapshots.data.docs[index].data()
                    //               as Map<String, dynamic>;
                    //           return Text(
                    //             data['name'],

                    //             style: TextStyle(color: Colors.black),
                    //           );
                    //         }),
                    //       );
                    //     }),
                  )
                ],
              ),
            ),
          );
  }
}
