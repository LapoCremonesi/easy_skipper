import 'package:flutter/material.dart';

class HomePageBoxView extends StatelessWidget {
  const HomePageBoxView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width / 2 - 20,
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
          const Text("Via Azeinda"),
        ],
      ),
    );
  }
}