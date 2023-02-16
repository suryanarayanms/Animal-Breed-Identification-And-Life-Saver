// //import 'dart:html';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_tflite/flutter_tflite.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:the_dog_project/Pet%20Adoption/final.dart';

// class Home extends StatefulWidget {
//   const Home({Key key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   bool _loading = true;
//   File _image;
//   List _output;
//   final picker = ImagePicker();
//   var path;

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
//         model: 'assets/images/model_unquant.tflite',
//         labels: 'assets/images/labels.txt');
//   }

//   pickImage() async {
//     var image = await picker.pickImage(source: ImageSource.camera);
//     if (image == null) return null;

//     setState(() {
//       _image = File(image.path);
//     });
//     detectImage(_image);
//   }

//   pickGalleryImage() async {
//     var image = await picker.pickImage(source: ImageSource.gallery);
//     if (image == null) return null;

//     setState(() {
//       _image = File(image.path);
//     });
//     detectImage(_image);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     loadModel() async {
//       await Tflite.loadModel(
//           model: 'assets/images/model_unquant.tflite',
//           labels: 'assets/images/labels.txt');
//     }

//     return Scaffold(
//       backgroundColor: Colors.blueAccent,
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const SizedBox(height: 50),
//             const Text('Md. Ashaf Uddaula presents-',
//                 style: TextStyle(color: Colors.white, fontSize: 20)),
//             const SizedBox(height: 5),
//             const Text(
//               'Cat & Dog Detector Application',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 30),
//             ),
//             const SizedBox(height: 50),
//             Center(
//               child: _loading
//                   ? Container(
//                       width: 350,
//                       child: Column(
//                         children: <Widget>[
//                           Image.asset('assets/cat_dog_icon.png'),
//                           const SizedBox(height: 50),
//                         ],
//                       ),
//                     )
//                   : Container(
//                       child: Column(
//                         children: <Widget>[
//                           Container(
//                             height: 250,
//                             child: Image.file(_image),
//                           ),
//                           const SizedBox(height: 20),
//                           _output != null
//                               ? Text(
//                                   'It is a ${_output[0]['label']}',
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 15),
//                                 )
//                               : Container(),
//                           SizedBox(height: 10),
//                         ],
//                       ),
//                     ),
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: () {
//                       pickImage();
//                     },
//                     child: Container(
//                       width: MediaQuery.of(context).size.width - 250,
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 2, vertical: 18),
//                       decoration: BoxDecoration(
//                         color: Colors.purple,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: const Text(
//                         'Capture Image',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   GestureDetector(
//                     onTap: () {
//                       pickGalleryImage();
//                     },
//                     child: Container(
//                       width: MediaQuery.of(context).size.width - 250,
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 5, vertical: 18),
//                       decoration: BoxDecoration(
//                         color: Colors.teal,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: const Text(
//                         'Select Image',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 children: <Widget>[
//                   const SizedBox(height: 5),
//                   GestureDetector(
//                     onTap: () async {
//                       if (_output[0]['label'] == 'Dog') {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => FinalPage(_image)));
//                       }
//                     },
//                     child: Container(
//                       width: MediaQuery.of(context).size.width - 250,
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 5, vertical: 18),
//                       decoration: BoxDecoration(
//                         color: Colors.teal,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: const Text(
//                         'Check breed',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
