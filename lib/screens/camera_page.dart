import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print("No image");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: _image == null
            ? const Text("No captured photos")
            : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: const Icon(Icons.add_a_photo),
        backgroundColor: Colors.blue,
      ),
    );
  }
}