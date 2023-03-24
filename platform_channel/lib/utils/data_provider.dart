import 'dart:io';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '/utils/service.dart';
import '../models/breed.dart';

final serviceProvider = Provider<AppService>((ref) => AppService());

final photoProvider = StateProvider<String>((ref) {
  return "";
});

final breedProvider = FutureProvider<List<Breed>>((ref) async {
  var service = ref.watch(serviceProvider);

  List<Breed> breeds = [];
  List<String> names = await service.fetchBreeds();

  for (var name in names) {
    String newImage = await service.fetchRandomImages(name);
    final breed = Breed(name, newImage);
    breeds.add(breed);
  }
  return breeds;

});

final imageProvider = FutureProvider.family<List<String>, String>((ref, name) async {
  var service = ref.watch(serviceProvider);

  List<String> photos = await service.fetchImages(name);

  return photos;

});