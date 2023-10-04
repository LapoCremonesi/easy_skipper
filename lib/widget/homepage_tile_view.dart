import 'package:easy_skipper/object/custom_agency.dart';
import 'package:flutter/material.dart';

class HomePageTileView extends StatefulWidget {
  const HomePageTileView({
    super.key,
    required this.agency,
  });

  final CustomAgency agency;

  @override
  State<HomePageTileView> createState() => _HomePageTileViewState();
}

class _HomePageTileViewState extends State<HomePageTileView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: 80,
      width: width,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
      child: Row(
        children: [
          Container(
            height: 80,
            width: width / 4 - 10,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
          ),
          Container(
            height: 80,
            width: width - width / 4 - 10,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 5),
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Nome Azienda",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Via Azienda"),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 20,
                    width: 20,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
