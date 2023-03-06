class Breed {
  final List<String> message;

  const Breed({
    required this.message,
  });

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(message: json["message"].cast<String>());
  }
}

// class RandomBreedImage {
//   final String message;

//   const RandomBreedImage({
//     required this.message,
//   });

//   factory RandomBreedImage.fromJson(Map<String, dynamic> json) {
//     return RandomBreedImage(
//       message: json['message'],
//     );
//   }
// }
