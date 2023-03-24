import 'dart:io';

import 'package:dogs_breeds/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/breed.dart';

class BreedItemView extends StatelessWidget {

  BreedItemView();

  @override
  Widget build(BuildContext context) {
    final breed = Provider.of<Breed>(context);

    return Platform.isIOS
        ? _createiOSTappableView(context, breed)
        : _createAndroidTappableView(context, breed);
  }

  GestureDetector _createiOSTappableView(BuildContext context, Breed breed) {
    return GestureDetector(
      onTap: () => _selectCategory(context, breed.name),
      child: _createCellView(breed),
    );
  }

  InkWell _createAndroidTappableView(BuildContext context, Breed breed) {
    return InkWell(
      onTap: () => _selectCategory(context, breed.name),
      child: _createCellView( breed),
    );
  }

  Container _createCellView(Breed breed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.brown.shade800, width: 3),
      ),
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7.0),
          child: GridTile(
            footer: Container(
              height: 40,
              color: Colors.amber.withOpacity(.5),
              child: Row(
                children: [
                  CupertinoButton(
                    child: breed.isFavorite
                        ? Icon(
                            CupertinoIcons.star_fill,
                            color: Colors.white,
                          )
                        : Icon(
                            CupertinoIcons.star,
                            color: Colors.white,
                          ),
                    onPressed: () {
                      breed.toogleFavorite();
                    },
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(
                    width: 90,
                    child: Text(
                      breed.name.toUpperCase(),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7.0),
              child: Image.network(
                breed.randomImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectCategory(BuildContext context, String name) {
    context.goNamed(
      AppRoutes.specifBreed,
      params: {"name": name.toString()},
    );
  }
}