import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcaMotore extends StatefulWidget {
  const BarcaMotore({super.key});

  @override
  State<BarcaMotore> createState() => _BarcaMotoreState();
}

class _BarcaMotoreState extends State<BarcaMotore> {
  String tipoMotore = "";
  int numeroMotori = 0;
  TextEditingController numeroMotoriController = TextEditingController();
  List<TextEditingController> marcaMotoriControllers = [];
  List<TextEditingController> numeroCavalliControllers = [];

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
          Container(
            height: 50,
            width: width,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: numeroMotoriController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                setState(() {
                  numeroCavalliControllers = [];
                  marcaMotoriControllers = [];
                  numeroMotori = numeroMotoriController.text.isEmpty
                      ? 0
                      : int.parse(numeroMotoriController.text);
                  for (var i = 0; i < numeroMotori; i++) {
                    numeroCavalliControllers.add(TextEditingController());
                    marcaMotoriControllers.add(TextEditingController());
                  }
                });
              },
              decoration: const InputDecoration(
                hintText: "Numero motori",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 55.0 * numeroMotori,
            child: ListView.builder(
              itemCount: numeroMotori,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      height: 50,
                      width: width / 2 - 15,
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 5,
                        bottom: 5,
                      ),
                      child: DropdownMenu(
                        controller: marcaMotoriControllers[index],
                        width: width / 2 - 15,
                        hintText: "Marca motore",
                        dropdownMenuEntries: const [
                          DropdownMenuEntry(value: "Honda", label: "Honda"),
                          DropdownMenuEntry(value: "Suzuki", label: "Suzuki"),
                          DropdownMenuEntry(value: "Yamaha", label: "Yamaha"),
                          DropdownMenuEntry(value: "Tohatsu", label: "Yohatsu"),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: width / 2 - 15,
                      margin: const EdgeInsets.only(
                        left: 5,
                        right: 10,
                        bottom: 5,
                      ),
                      child: TextField(
                        controller: numeroCavalliControllers[index],
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          hintText: "Numero cavalli",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 50,
            width: width,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: TextButton(
              onPressed: () {
                for (var i = 0; i < marcaMotoriControllers.length; i++) {
                  print(
                    "Marca ${marcaMotoriControllers[i].text} // Cavalli ${numeroCavalliControllers[i].text}",
                  );
                }
                print("------------------------------------");
              },
              child: Text("data"),
            ),
          )
        ],
      ),
    );
  }
}
