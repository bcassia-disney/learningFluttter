import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'view/screens/breeds_list_view.dart';
import 'dart:io';


void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return const CupertinoApp(
        title: "Breeds",
        home: BreedsListView(),
      );
    } else {
      return const MaterialApp(
        title: "Breeds",
        home: BreedsListView(),
      );
    }
  }
}
