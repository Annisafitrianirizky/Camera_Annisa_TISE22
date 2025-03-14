import 'package:camera_annisa_tise22/widget/hasil_filter.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
//import 'filter_carousel.dart';

//import 'displaypicture_screen.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen(
    {
      super.key, 
      required this.camera
    }
  );

  final CameraDescription camera;

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture - 1122140008')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            if(!context.mounted) return;

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HasilFilter(
                  imagePath: image.path
                  )
              )
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}