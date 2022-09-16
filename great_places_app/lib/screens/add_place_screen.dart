import 'dart:io';

import 'package:cocoicons/cocoicons.dart';
import 'package:great_places_app/widgets/location_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/user_places.dart';
import '../widgets/input_image.dart';

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
    Navigator.of(context).pop();
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
                    const SizedBox(height: 10),
                    LocationInput(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(
              CocoIconLine.Check,
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
