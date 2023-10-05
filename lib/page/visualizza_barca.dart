import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/barca.dart';
import 'package:flutter/material.dart';

class VisualizzaBarca extends StatefulWidget {
  const VisualizzaBarca({
    super.key,
    required this.barcheInfo,
  });

  final Barche barcheInfo;

  @override
  State<VisualizzaBarca> createState() => _VisualizzaBarcaState();
}

class _VisualizzaBarcaState extends State<VisualizzaBarca> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 250,
                  width: width,
                  color: bluOceanoProfondo,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                          left: 10,
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
                      const Center(
                        child: Icon(
                          Icons.business_rounded,
                          size: 50,
                          color: Colors.white,
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
