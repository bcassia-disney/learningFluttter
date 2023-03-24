import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/single_breed_view_model.dart';
import '../single_item_view.dart';

class SingleBreedView extends StatefulWidget {
  String name;

  SingleBreedView({super.key, required this.name});

  @override
  State<SingleBreedView> createState() => SingleBreedViewState(name: name);
}

class SingleBreedViewState extends State<SingleBreedView> {
  String name;
  var viewModel = SingleBreedViewModel();

  SingleBreedViewState({required this.name});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _createCupertinoPageScaffold(name) : _createScaffold(name);
  }

  @override
  void initState() {
    viewModel.loadImages(name);
    super.initState();
  }

  CupertinoPageScaffold _createCupertinoPageScaffold(String name) {
    var navBar = CupertinoNavigationBar(
      middle: Text(name.toUpperCase()),
    );

    return CupertinoPageScaffold(
      navigationBar: navBar,
      child: SafeArea(
        bottom: false,
        child: ChangeNotifierProvider<SingleBreedViewModel>(
          create: (BuildContext context) => viewModel,
          child: Consumer<SingleBreedViewModel>(builder: (context, viewModel, _) {
            return _createCupertinoScrollBarView();
          }),
        ),
      ),
    );
  }

  CupertinoScrollbar _createCupertinoScrollBarView() {
    final controller = ScrollController();
    return CupertinoScrollbar(
      controller: controller,
      child: _createGridView(controller),
    );
  }

  Scrollbar _createScrollBarView() {
    final controller = ScrollController();
    return Scrollbar(
      controller: controller,
      child: _createGridView(controller),
    );
  }

  GridView _createGridView(ScrollController controller) {
    return GridView.count(
      primary: false,
      crossAxisCount: 2,
      controller: controller,
      children: List.generate(viewModel.images.length, (index) {
        return SingleItemView(
          image: viewModel.images[index],
        );
      }),
    );
  }

  Scaffold _createScaffold(String name) {
    return Scaffold(
      appBar: AppBar(title: Text(name.toUpperCase())),
      body: ChangeNotifierProvider<SingleBreedViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<SingleBreedViewModel>(builder: (context, viewModel, _) {
          return _createScrollBarView();
        }),
      ),
    );
  }
}