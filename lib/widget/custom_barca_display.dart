import 'package:easy_skipper/object/barca.dart';
import 'package:easy_skipper/page/visualizza_barca.dart';
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return VisualizzaBarca(barcheInfo: barcaInfo);
            },
          ),
        );
      },
      child: Container(
        height: 100,
        width: width,
        margin: const EdgeInsets.only(left: 10, right: 10),
        decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.black,
            ),
            Container(
              height: 100,
              width: width - 100 - 20,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  barcaInfo.nome,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
