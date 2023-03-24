
import 'package:dogs_breeds/models/breed.dart';
import 'package:flutter/widgets.dart';

import '../../utils/breedys_service.dart';

class BreedsListViewModel extends ChangeNotifier {
  List<Breed> breeds = [];

  BreedsListViewModel();

  void loadData(BuildContext context) async {

    var randomImages = [];

    List<String> newBreeds = await BreedysService.shared.fetchBreeds();

    for (int breed = 0; breed < newBreeds.length; breed++) {
      String newImage = await BreedysService.shared.fetchRandomImages(newBreeds[breed]);
      randomImages.add(newImage);

      breeds.add(Breed(name: newBreeds[breed], randomImage: randomImages[breed], images: []));
      notifyListeners();
    }
  }
}