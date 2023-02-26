import 'package:flutter/widgets.dart';
import '../../utils/breedys_service.dart';

class BreedsListViewModel extends ChangeNotifier {
  List<String> breeds = [];
  List<String> images = [];

  BreedsListViewModel();

  void loadData() async {
    List<String> newBreeds = await BreedysService.shared.fetchBreeds();
    breeds = newBreeds;

    for (var breed in breeds) {
      String newImage =
          await BreedysService.shared.fetchRandomImages(breed);
      images.add(newImage);
      notifyListeners();
    }

  }
}
