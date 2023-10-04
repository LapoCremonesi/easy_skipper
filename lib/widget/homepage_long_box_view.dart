import 'package:easy_skipper/object/custom_agency.dart';
import 'package:flutter/material.dart';

class HomePageLongBoxView extends StatefulWidget {
  const HomePageLongBoxView({
    super.key,
    required this.agency,
  });

  final CustomAgency agency;

  @override
  State<HomePageLongBoxView> createState() => _HomePageLongBoxViewState();
}

class _HomePageLongBoxViewState extends State<HomePageLongBoxView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width - 20,
      height: 280,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: 180,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
          const Text(
            "Nome Azienda",
            style: TextStyle(fontSize: 25),
          ),
          const Text("Via Azienda"),
        ],
      ),
    );
  }
}
