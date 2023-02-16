// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_tflite/flutter_tflite.dart';
// import 'package:provider/provider.dart';
// import 'package:the_dog_project/Pet%20Adoption/smaple.dart';
// import 'package:the_dog_project/Pet%20Adoption/theme.dart';

// class FinalPage extends StatefulWidget {
//   final File _image;

//   const FinalPage(
//     this._image, {
//     Key key,
//   }) : super(key: key);

//   @override
//   State<FinalPage> createState() => _FinalPageState();
// }

// class _FinalPageState extends State<FinalPage> {
//   bool _loading = true;
//   File _image;
//   List _output;

//   @override
//   void initState() {
//     super.initState();
//     loadModel().then((value) {
//       setState(() {});
//     });
//   }

//   detectImage(File image) async {
//     var output = await Tflite.runModelOnImage(
//         path: image.path,
//         numResults: 2,
//         threshold: 0.6,
//         imageMean: 127.5,
//         imageStd: 127.5);
//     setState(() {
//       _output = output;
//       _loading = false;
//     });
//   }

//   loadModel() async {
//     await Tflite.loadModel(
//         model: 'assets/images/Dog/model_unquant.tflite',
//         labels: 'assets/images/Dog/labels.txt');
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     {
//       _image = widget._image;
//       detectImage(_image);
//       return Scaffold(
//         body: WillPopScope(
//           onWillPop: () async {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (BuildContext context) => Home(),
//               ),
//               (route) => false,
//             );
//           },
//           child: Center(
//             child: GestureDetector(
//                 onTap: (() => {
//                       print(_image),
//                       print(widget._image),
//                       for (int i = 0; i < 1; i++) {print(_output[i]['label'])}
//                     }),
//                 child: Text(
//                   _loading == true ? 'Wait' : 'It is a ${_output[0]['label']}',
//                   style: TextStyle(color: Colors.black),
//                 )),
//           ),
//         ),
//       );
//     }
//   }
// }
