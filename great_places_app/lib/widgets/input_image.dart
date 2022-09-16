import 'dart:io';

import 'package:cocoicons/cocoicons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class InputImage extends StatefulWidget {
  final Function onSelectImage;
  InputImage(this.onSelectImage);

  @override
  State<InputImage> createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  File? _storedImages;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImages = File(imageFile!.path);
    });
    final appDir =
        await sysPath.getApplicationDocumentsDirectory(); // gets app Directory
    final fileName = path.basename(imageFile.path); // Name the file of picture
    final savedImage = await _storedImages!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImages != null
              ? Image.file(
                  _storedImages!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No image taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            label: const Text('Take Picture'),
            icon: const Icon(CocoIconLine.Camera),
            onPressed: _takePicture,
          ),
        )
      ],
    );
  }
}
