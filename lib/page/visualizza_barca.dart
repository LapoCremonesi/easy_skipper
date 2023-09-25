import 'package:easy_skipper/object/barca.dart';
import 'package:flutter/material.dart';

class VisualizzaBarca extends StatelessWidget {
  const VisualizzaBarca({
    super.key,
    required this.barcheInfo,
  });

  final Barche barcheInfo;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      body: Container(
        height: height - 56 - statusBarHeight,
        width: width,
      ),
    );
  }
}
