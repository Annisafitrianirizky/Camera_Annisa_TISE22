import 'package:camera_annisa_tise22/widget/filter_carousel.dart';
import 'package:camera_annisa_tise22/widget/takepicture_screen.dart';
//import 'package:camera_annisa_tise22/widget/takepicture_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  
  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: //PhotoFilterCarousel(), 
      TakePictureScreen(camera: camera,),
      debugShowCheckedModeBanner: false,
    );
  }
}
