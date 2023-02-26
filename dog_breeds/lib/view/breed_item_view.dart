import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'screens/single_breed_view.dart';

class BreedItemView extends StatelessWidget {
  String name;
  String image;

  BreedItemView({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _createiOSTappableView(context, name)
        : _createAndroidTappableView(context, name);
  }

  GestureDetector _createiOSTappableView(BuildContext context, String name) {
    return GestureDetector(
      onTap: () => _selectCategory(context, name),
      child: _createCellView(name),
    );
  }

  InkWell _createAndroidTappableView(BuildContext context, String name) {
    return InkWell(
      onTap: () => _selectCategory(context, name),
      child: _createCellView(name),
    );
  }

  Container _createCellView(String name) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.brown.shade800, width: 3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7.0),
        child: GridTile(
          footer: Container(
            height: 40,
            color: Colors.amber.withOpacity(.5),
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Text(
                name.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  void _selectCategory(BuildContext context, String name) {
    Platform.isIOS
        ? Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => SingleBreedView(name: name)),
          )
        : Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleBreedView(name: name)),
          );
  }
}
