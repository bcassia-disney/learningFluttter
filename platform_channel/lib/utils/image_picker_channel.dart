import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ImageSourceType { photos, camera }

String _stringImageSource(ImageSourceType imageSource) {
  switch (imageSource) {
    case ImageSourceType.photos:
      return 'photos';
    case ImageSourceType.camera:
      return 'camera';
  }
}

class ImagePickerChannel {
  static const platform =
  const MethodChannel('com.musevisions.flutter/imagePicker');

  Future<String> getImage({required ImageSourceType imageSource}) async {
    final stringImageSource = _stringImageSource(imageSource);
    final result = await platform.invokeMethod('pickImage', stringImageSource);
    return result;
  }
}