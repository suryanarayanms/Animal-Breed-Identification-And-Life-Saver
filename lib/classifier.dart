import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class Classifier {
  Classifier();

  classifyImage(var image) async {
    var inputImage = File(image.path);

    ImageProcessor imageProcessor = ImageProcessorBuilder()
    .add(ResizeOp(300, 300, ResizeMethod.BILINEAR))
    .add(NormalizeOp(0, 255))
    .build();

    
    TensorImage tensorImage = TensorImage.fromFile(inputImage);
    tensorImage = imageProcessor.process(tensorImage);
    
    TensorBuffer probabilityBuffer = 
        TensorBuffer.createFixedSize(<int>[1, 120], TfLiteType.float32);

    try {
      Interpreter interpreter = await Interpreter.fromAsset("b3_acc_86_7.tflite");
      print('Interpreter Created Successfully');
      interpreter.run(tensorImage.buffer, probabilityBuffer.buffer);
      print('Interpreter run Successfully');
    } catch(e) {
      print("Error loading or running model: " + e.toString());
    }

    List<String> labels = await FileUtil.loadLabels("assets/labels.txt");
    TensorProcessor probabilityProcessor =
        TensorProcessorBuilder().build();
    TensorLabel tensorLabel = TensorLabel.fromList(
    labels, probabilityProcessor.process(probabilityBuffer));

    Map labeledProb = tensorLabel.getMapWithFloatValue();
    double highestProb = 0;
    String dogName;
    
    labeledProb.forEach((breed, probability) {
      if (probability*100 > highestProb){
        highestProb = probability*100;
        dogName = breed;
      }
    });
    var outputProb = highestProb.toStringAsFixed(1);
    return [dogName, outputProb];
  }
}