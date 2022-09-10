import 'package:cocoicons/cocoicons.dart';
import 'package:flutter/material.dart';
import 'package:great_places_app/providers/user_places.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Places'), actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AddPlaceScreen.routeName);
          },
          icon: const Icon(
            CocoIconLine.Add,
            size: 30,
          ),
        ),
      ]),
      body: Consumer<UserPlace>(
        child: const Center(child: Text('No places yet!,Try adding some')),
        builder: (context, placevalue, ch) => placevalue.items.isEmpty
            ? ch!
            : ListView.builder(
                itemCount: placevalue.items.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(
                      placevalue.items[index].image,
                    ),
                  ),
                  title: Text(placevalue.items[index].title),
                  onTap: () {},
                ),
              ),
      ),
    );
  }
}
