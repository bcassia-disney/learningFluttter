import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/data_provider.dart';

import '../single_item_view.dart';

class SingleBreedView extends ConsumerWidget {

  String name;

  SingleBreedView({required this.name});

  @override
  Widget build(BuildContext context, ref) {
    return _createScaffold(name, ref);
  }

  Scaffold _createScaffold(String name, ref) {
    AsyncValue<List<String>> images = ref.watch(imageProvider(name));

    return Scaffold(
      appBar: AppBar(title: Text(name.toUpperCase())),
      body: images.when(data: (data) {
        return _createScrollBarView(data);
      }, error: (error, stackTrace) {
        return Container();
      }, loading: () {
        return Center(child: CircularProgressIndicator());
      }),
    );
  }

  Scrollbar _createScrollBarView(List<String> data) {
    final controller = ScrollController();
    return Scrollbar(
      scrollbarOrientation: ScrollbarOrientation.top,
      controller: controller,
      child: _createGridView(controller, data),
    );
  }

  GridView _createGridView(ScrollController controller, List<String> data) {
    return GridView.count(
      primary: false,
      crossAxisCount: 2,
      controller: controller,
      children: List.generate(data.length, (index) {
        return SingleItemView(image: data[index]);
      }),
    );
  }
}