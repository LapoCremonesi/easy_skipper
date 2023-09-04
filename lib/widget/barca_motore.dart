import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcaMotore extends StatefulWidget {
  const BarcaMotore({super.key});

  @override
  State<BarcaMotore> createState() => _BarcaMotoreState();
}

class _BarcaMotoreState extends State<BarcaMotore> {
  String tipoMotore = "";
  TextEditingController numeroMotori = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Container(
            height: 50,
            width: width,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                hintText: "Lunghezza Barca",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 50,
            width: width,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                hintText: "Larghezza Barca",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Container(
                height: 50,
                width: width / 2 - 20,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: numeroMotori,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    hintText: "Numero motori",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50.0 *
                (numeroMotori.text.isEmpty ? 0 : int.parse(numeroMotori.text)),
            child: ListView.builder(
              itemCount:
                  numeroMotori.text.isEmpty ? 0 : int.parse(numeroMotori.text),
              itemBuilder: (context, index) {
                return const Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: DropdownMenu(
                        hintText: "",
                        dropdownMenuEntries: [
                          DropdownMenuEntry(value: "Honda", label: "Honda"),
                          DropdownMenuEntry(value: "Suzuki", label: "Suzuki"),
                          DropdownMenuEntry(value: "Yamaha", label: "Yamaha"),
                          DropdownMenuEntry(value: "Tohatsu", label: "Yohatsu"),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
