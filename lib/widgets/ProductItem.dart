import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final int index;

  ProductItem({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: index == 0 ? 16 : 0, bottom: index == 9 ? 16 : 0),
      child: Text(index.toString()),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(8)),
    );
  }
}