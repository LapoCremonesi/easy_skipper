import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/barca.dart';
import 'package:flutter/material.dart';

class BarcaInfo extends StatefulWidget {
  const BarcaInfo({
    super.key,
    required this.barcheInfo,
  });

  final Barche barcheInfo;

  @override
  State<BarcaInfo> createState() => _VisualizzaBarcaState();
}

class _VisualizzaBarcaState extends State<BarcaInfo> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 250 + statusBarHeight,
                  width: width,
                  decoration: BoxDecoration(
                    color: bluOceanoProfondo,
                    image: DecorationImage(
                      image: NetworkImage(
                        '$api${widget.barcheInfo.smallImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: statusBarHeight,
                          left: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: arancioneBoa,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 60,
              width: width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 190, 189, 189),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Text(
                  "Nome Barca: ${widget.barcheInfo.nome}",
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 60,
              width: width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 190, 189, 189),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Text(
                  "Larghezza: ${widget.barcheInfo.larghezza}",
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 60,
              width: width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 190, 189, 189),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Text(
                  "Lunghezza: ${widget.barcheInfo.lunghezza}",
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
