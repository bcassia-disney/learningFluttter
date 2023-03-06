import 'package:flutter/widgets.dart';
import '../../utils/breedys_service.dart';

class SingleBreedViewModel extends ChangeNotifier {

  List<String> images = [];

  SingleBreedViewModel();

  void loadImages(String breed) async {
    List<String> newImages = await Service.shared.fetchImages(breed);
    images = newImages;
    notifyListeners();
  }
}
