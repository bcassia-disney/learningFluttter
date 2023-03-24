import 'package:flutter/material.dart';

class Breed extends ChangeNotifier {
  String name;
  String randomImage;
  List<String> images;
  bool isFavorite = false;

  Breed({
    required this.name,
    required this.randomImage,
    required this.images
  });

  toogleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}