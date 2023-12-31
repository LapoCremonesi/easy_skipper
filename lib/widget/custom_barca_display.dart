import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/barca.dart';
import 'package:easy_skipper/page/barca_info.dart';
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
              return BarcaInfo(barcheInfo: barcaInfo);
            },
          ),
        );
      },
      child: Container(
        height: 100,
        width: width,
        margin: const EdgeInsets.only(left: 10, right: 10),
        decoration: const BoxDecoration(
          color: arancioneBoa,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            barcaInfo.image != ""
                ? Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: arancioneBoa,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(barcaInfo.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      color: arancioneBoa,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: const Icon(
                      Icons.directions_boat_filled_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
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
