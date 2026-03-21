import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  Uint8List? imageData;
  final picker = ImagePicker();
  final box = Hive.box('cameraImages');

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera, // works on web, opens file picker
      maxWidth: 600,
    );
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() => imageData = bytes);

      // Save to Hive
      box.put('lastPhoto', bytes);
    }
  }

  @override
  void initState() {
    super.initState();

    // Load saved image
    final saved = box.get('lastPhoto');
    if (saved != null) {
      imageData = saved;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageData != null)
          Image.memory(imageData!, width: 200, height: 200, fit: BoxFit.cover),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: pickImage,
          child: const Text('Take Photo / Pick Image'),
        ),
      ],
    );
  }
}