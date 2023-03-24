import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/breed.dart';
import 'breed_item_view.dart';

class BreedsListView extends ConsumerWidget {
  List<Breed> data;
  ScrollController controller;
  Image? imageFile;

  BreedsListView({required this.data, required this.controller, required this.imageFile});

  @override
  Widget build(BuildContext context, ref) {
    return CustomScrollView(slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      _getSectionTitle(index),
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ],
              ),
              GridView.count(
                controller: controller,
                crossAxisCount: index == 0 ? 1 : 2,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(index == 0 ? 1 : data.length, (idx) {
                  return index == 0 ?  cassia(imageFile): BreedItemView(
                    name: data[idx].name,
                    image: data[idx].image,
                  );
                }),
              )
            ],
          );
        }, childCount: 2),
      ),
    ]);
  }

  String _getSectionTitle(int index) {
    if (index == 0) {
      return "My Dog";
    }
    return "Breeds";
  }

  Widget cassia(Image? file) {
    if (file != null) {
    return file;
    }
   return Center(child: Text("CAssia"));
  }
}