import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../view_models/breed_list_view_model.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../breed_item_view.dart';

class BreedsListView extends StatefulWidget {
  const BreedsListView({super.key});

  @override
  State<BreedsListView> createState() => _BreedsListViewState();
}

class _BreedsListViewState extends State<BreedsListView> {
  var viewModel = BreedsListViewModel();

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _createCupertinoPageScaffold() : _createScaffold();
  }

  @override
  void initState() {
    viewModel.loadData();
    super.initState();
  }

  CupertinoPageScaffold _createCupertinoPageScaffold() {
    var navBar = const CupertinoNavigationBar(middle: Text("Breeds"));

    return CupertinoPageScaffold(
      navigationBar: navBar,
      child: SafeArea(
        bottom: false,
        child: ChangeNotifierProvider<BreedsListViewModel>(
          create: (BuildContext context) => viewModel,
          child:
          Consumer<BreedsListViewModel>(builder: (context, viewModel, _) {
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
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      controller: controller,
      children: List.generate(viewModel.images.length, (index) {
        return BreedItemView(
          name: viewModel.breeds[index],
          image: viewModel.images[index],
        );
      }),
    );
  }

  Scaffold _createScaffold() {
    return Scaffold(
      appBar: AppBar(title: const Text("Breeds")),
      body: ChangeNotifierProvider<BreedsListViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<BreedsListViewModel>(builder: (context, viewModel, _) {
          return _createScrollBarView();
        }),
      ),
    );
  }
}
