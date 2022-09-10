import 'dart:io';

import 'package:cocoicons/cocoicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:great_places_app/providers/user_places.dart';
import 'package:great_places_app/widgets/input_image.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _textController = TextEditingController();
  File? _pickImage;
  void _onPickImage(File pickImage) {
    _pickImage = pickImage;
  }

  void _savePlace() {
    if (_textController.text.isEmpty || _pickImage == null) {
      return;
    }
    Provider.of<UserPlace>(context, listen: false)
        .addPlace(_textController.text, _pickImage!);
  }

  @override
  Widget build(BuildContext context) {
    final themeCol = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _textController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: 10),
                    InputImage(_onPickImage),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              CocoIconLine.Add,
              size: 30,
            ),
            label: const Text('Submit'),
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    fontSize: 22,
                  ),
                ),
                foregroundColor: MaterialStateProperty.all(themeCol.primary),
                backgroundColor: MaterialStateProperty.all(themeCol.secondary),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0))),
                elevation: MaterialStateProperty.all(0),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10)),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          ),
        ],
      ),
    );
  }
}
