import 'package:flutter/material.dart';

class BarcaVela extends StatefulWidget {
  const BarcaVela({super.key});

  @override
  State<BarcaVela> createState() => _BarcaVelaState();
}

class _BarcaVelaState extends State<BarcaVela> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      child: Column(
        children: [
          TextField(),
        ],
      ),
    );
  }
}
