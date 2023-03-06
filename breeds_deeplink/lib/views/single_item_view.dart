import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SingleItemView extends StatefulWidget {
  String image;

  SingleItemView({super.key, required this.image});

  @override
  State<SingleItemView> createState() => _SingleItemViewState();
}

class _SingleItemViewState extends State<SingleItemView> {
  @override
  Widget build(BuildContext context) {
    return _createCellView();
  }

  Widget _createCellView() {
    return Image.network(
      widget.image,
      fit: BoxFit.cover,
    );
  }
}
