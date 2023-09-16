import 'package:easy_skipper/object/barca.dart';
import 'package:flutter/material.dart';

class CustomBarcaDisplay extends StatelessWidget {
  const CustomBarcaDisplay({
    super.key,
    required this.barcaInfo,
  });

  final Barche barcaInfo;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 100,
      width: width,
      margin: const EdgeInsets.only(left: 10, right: 10),
      color: Colors.amber,
      child: ListTile(
        leading: Container(
          height: 100,
          width: 50,
          color: Colors.black,
        ),
        title: Text(barcaInfo.nome),
      ),
    );
  }
}
