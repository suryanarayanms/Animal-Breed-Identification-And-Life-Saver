import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Viewrequest extends StatefulWidget {
  final String reqID;
  final String comment;
  final String location;
  final String landmark;
  final String issue;
  final String imageurl;
  final String status;
  final String note;
  final String statusImage;
  final String phoneNumber;
  final String handledby;
  final String handlerphoneNumber;
  final String reason;
  Viewrequest({
    Key key,
    this.reqID,
    this.comment,
    this.location,
    this.landmark,
    this.issue,
    this.imageurl,
    this.status,
    this.note,
    this.statusImage,
    this.phoneNumber,
    this.handledby,
    this.handlerphoneNumber,
    this.reason,
  }) : super(key: key);

  @override
  State<Viewrequest> createState() => _ViewrequestState();
}

class _ViewrequestState extends State<Viewrequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    'your request',
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
          widget.status == "secured"
              ? Padding(
                  padding: const EdgeInsets.only(
                    // top: 30,
                    left: 30,
                    right: 30.0,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          autofocus: false,
                          autocorrect: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "BebasNeue",
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              hintMaxLines: 5,
                              enabled: false,
                              counterText: '',
                              hintText: widget.status,
                              hintStyle: TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                  color: Colors.black),
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
                          decoration: InputDecoration(
                              hintMaxLines: 5,
                              enabled: false,
                              counterText: '',
                              hintText: "handled by:  " + widget.handledby,
                              hintStyle: TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                  color: Colors.black),
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
                          decoration: InputDecoration(
                              hintMaxLines: 5,
                              enabled: false,
                              counterText: '',
                              hintText:
                                  "contact:  " + widget.handlerphoneNumber,
                              hintStyle: TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                  color: Colors.black),
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
                          decoration: InputDecoration(
                              enabled: false,
                              counterText: '',
                              hintText: "reason:  " + widget.reason,
                              hintStyle: TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                  color: Colors.black),
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
                      ]))
              : Padding(
                  padding: const EdgeInsets.only(
                    // top: 30,
                    left: 30,
                    right: 30.0,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          autofocus: false,
                          autocorrect: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "BebasNeue",
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              hintMaxLines: 5,
                              enabled: false,
                              counterText: '',
                              hintText: widget.location,
                              hintStyle: TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                  color: Colors.black),
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
                          decoration: InputDecoration(
                              enabled: false,
                              counterText: '',
                              hintText: "issue: " + widget.issue,
                              hintStyle: TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                  color: Colors.black),
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
                          decoration: InputDecoration(
                              enabled: false,
                              counterText: '',
                              hintText: widget.comment,
                              hintStyle: TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                  color: Colors.black),
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
                          decoration: InputDecoration(
                              enabled: false,
                              counterText: '',
                              hintText: widget.landmark,
                              hintStyle: TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                  color: Colors.black),
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
                          decoration: InputDecoration(
                              enabled: false,
                              counterText: '',
                              hintText: "status: " + widget.status,
                              hintStyle: TextStyle(
                                  fontFamily: "BebasNeue",
                                  fontSize: 20,
                                  color: Colors.black),
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
                        widget.status == "active"
                            ? Column(
                                children: [
                                  TextField(
                                    autofocus: false,
                                    autocorrect: false,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "BebasNeue",
                                    ),
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        enabled: false,
                                        counterText: '',
                                        hintText:
                                            "handled by:  " + widget.handledby,
                                        hintStyle: TextStyle(
                                            fontFamily: "BebasNeue",
                                            fontSize: 20,
                                            color: Colors.black),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
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
                                    decoration: InputDecoration(
                                        enabled: false,
                                        counterText: '',
                                        hintText: "contact:  " +
                                            widget.handlerphoneNumber,
                                        hintStyle: TextStyle(
                                            fontFamily: "BebasNeue",
                                            fontSize: 20,
                                            color: Colors.black),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              )
                            : Center(),
                        widget.status == "rejected"
                            ? Column(
                                children: [
                                  TextField(
                                    autofocus: false,
                                    autocorrect: false,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "BebasNeue",
                                    ),
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        enabled: false,
                                        counterText: '',
                                        hintText:
                                            "handled by:  " + widget.handledby,
                                        hintStyle: TextStyle(
                                            fontFamily: "BebasNeue",
                                            fontSize: 20,
                                            color: Colors.black),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
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
                                    decoration: InputDecoration(
                                        enabled: false,
                                        counterText: '',
                                        hintText: "contact:  " +
                                            widget.handlerphoneNumber,
                                        hintStyle: TextStyle(
                                            fontFamily: "BebasNeue",
                                            fontSize: 20,
                                            color: Colors.black),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
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
                                    decoration: InputDecoration(
                                        enabled: false,
                                        counterText: '',
                                        hintText: "reason:  " + widget.reason,
                                        hintStyle: TextStyle(
                                            fontFamily: "BebasNeue",
                                            fontSize: 20,
                                            color: Colors.black),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )
                            : Center(),
                      ])),
          widget.status == "pending"
              ? Center(
                  child: GestureDetector(
                    onTap: () => {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection("my-request")
                          .doc(widget.reqID)
                          .delete(),
                      FirebaseFirestore.instance
                          .collection("requests")
                          .doc(widget.reqID)
                          .delete(),
                      Navigator.pop(context),
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
                          "close request",
                          style: TextStyle(
                              fontFamily: "BebasNeue",
                              fontSize: 25,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              : widget.status == "active"
                  ? Center()
                  : Center(),
        ]),
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
                // child: Text(
                // widget.note != null ? widget.imageurl : widget.note,
                // ),
                child: Image.network(
                  widget.imageurl,
                  width: 215,
                  height: 170,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
