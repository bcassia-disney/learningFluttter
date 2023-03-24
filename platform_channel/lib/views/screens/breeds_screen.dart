import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/breed.dart';
import '../../utils/data_provider.dart';
import '../breeds_list_view.dart';
import 'package:image_picker/image_picker.dart';

class BreedsScreen extends ConsumerWidget  {

  BreedsScreen({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _createScaffold(context, ref);
  }


  void _getFromGallery(ref) async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery);
    if (pickedFile != null) {
      ref.read(photoProvider.notifier).state = pickedFile.path;
    }
  }

  Scaffold _createScaffold(BuildContext context, ref) {
    AsyncValue<List<Breed>> breeds =  ref.watch(breedProvider);
    Image image = Image.file(File(ref.watch(photoProvider)));

    return Scaffold(
        appBar: AppBar(
            title: const Text("Breeds"),
            actions: Platform.isIOS
                ? [
              ButtonBar(
                children: [
                  ButtonBar(
                    children: [
                      InkWell(
                        child: const Icon(Icons.add),
                        onTap: () {
                          _showCupertinoActionSheet(context, ref);
                        },
                      )
                    ],
                  )
                ],
              )
            ]
                : []),
        body: breeds.when (
            loading: () => Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) {
              return Center(
                child: Text('$err'),
              );
            },
            data: (items) => _createScrollBarView(context, items, image)
        )
    );
  }

  Scrollbar _createScrollBarView(BuildContext context, List<Breed> data, Image? image) {
    final controller = ScrollController();
    return Scrollbar(
      controller: controller,
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: BreedsListView(data: data, controller:
          controller, imageFile: image),
        ),
        Platform.isAndroid
            ? Align(
          alignment: Alignment.bottomRight,
          // add your floating action button
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Wrap(
                    children: [
                      ListTile(
                        onTap: () {
                          print("Camera");
                        },
                        leading: const Icon(Icons.camera),
                        title: const Text('Camera'),
                      ),
                      ListTile(
                        onTap: () {
                          print("Photos");
                        },
                        leading: const Icon(Icons.photo),
                        title: const Text('Photos'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        )
            : Container(),
      ]),
    );
  }

  void _showCupertinoActionSheet(BuildContext context, ref) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          CupertinoActionSheet(
            title: const Text('Choosing image'),
            message: const Text('Choose a image from gallery or take a picture'),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                onPressed: () {
                  _getFromGallery(ref);
                  Navigator.pop(context);
                },
                child: const Text('Gallery'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  _getFromGallery(ref);
                  Navigator.pop(context);
                },
                child: const Text('Camera'),
              ),
            ],
          ),
    );
  }
}