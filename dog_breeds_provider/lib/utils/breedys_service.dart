import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BreedysService {
  static final BreedysService shared = BreedysService._internal();

  BreedysService._internal();

  Future<List<String>> fetchBreeds() async {
    final response =
        await http.get(Uri.parse("https://dog.ceo/api/breeds/list"));

    if (response.statusCode == 200) {
      List<String> breeds = jsonDecode(response.body)["message"].cast<String>();
      return breeds;
    } else {
      throw Exception('Failed to load breeds');
    }
  }

  Future<String> fetchRandomImages(String breed) async {
    final response = await http
        .get(Uri.parse("https://dog.ceo/api/breed/$breed/images/random"));

    if (response.statusCode == 200) {
      String image = jsonDecode(response.body)["message"];
      return image;
    } else {
      throw Exception('Failed to load random image of breed');
    }
  }

  Future<List<String>> fetchImages(String breed) async {
    final response =
        await http.get(Uri.parse("https://dog.ceo/api/breed/$breed/images"));

    if (response.statusCode == 200) {
      List<String> images = jsonDecode(response.body)["message"].cast<String>();
      return images;
    } else {
      throw Exception('Failed to load breeds');
    }
  }
}