import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SingleItemView extends StatelessWidget {
  String image;

  SingleItemView({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    return _createCellView();
  }

  Widget _createCellView() {
    return Image.network(
      image,
      fit: BoxFit.cover,
    );
  }
}
