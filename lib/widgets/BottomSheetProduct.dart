import 'package:flutter/material.dart';

import 'ProductItem.dart';

class BottomSheetProduct extends StatelessWidget {
  const BottomSheetProduct({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(16), topLeft: Radius.circular(16)),
      ),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ProductItem(index: index);
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 16);
        },
      ),
    );
  }
}
