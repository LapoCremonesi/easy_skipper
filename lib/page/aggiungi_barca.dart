import 'dart:convert';
import 'dart:io';
import 'package:easy_skipper/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AggiungiBarca extends StatefulWidget {
  const AggiungiBarca({super.key});

  @override
  State<AggiungiBarca> createState() => _AggiungiBarcaState();
}

enum TipoBarca { vela, motore, _null }

class _AggiungiBarcaState extends State<AggiungiBarca> {
  int numeroMotori = 0;
  TipoBarca radioButtonValue = TipoBarca._null;

  TextEditingController barcaMotoreLarghezza = TextEditingController();
  TextEditingController barcaMotoreLunghezza = TextEditingController();
  TextEditingController barcaMotoreNumeroMotori = TextEditingController();
  TextEditingController barcaMotoreNome = TextEditingController();
  List<TextEditingController> barcaMotoreMarcaMotori = [];
  List<TextEditingController> barcaMotoreNumeroCavalli = [];

  TextEditingController barcaVelaLarghezza = TextEditingController();
  TextEditingController barcaVelaLunghezza = TextEditingController();
  TextEditingController barcaVelaAltezza = TextEditingController();
  TextEditingController barcaVelaNome = TextEditingController();

  File? image;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Aggiungi una nuova barca",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ListTile(
            leading: Radio(
              value: TipoBarca.motore,
              groupValue: radioButtonValue,
              onChanged: (value) {
                setState(() {
                  radioButtonValue = value!;
                });
              },
            ),
            title: const Text("Motore"),
          ),
          ListTile(
            leading: Radio(
              value: TipoBarca.vela,
              groupValue: radioButtonValue,
              onChanged: (value) {
                setState(() {
                  radioButtonValue = value!;
                });
              },
            ),
            title: const Text("Vela"),
          ),
          SizedBox(
            height: height - statusBarHeight - 10 - 90 - 56 - 112,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, _) {
                return radioButtonValue == TipoBarca._null
                    ? Container()
                    : radioButtonValue == TipoBarca.motore
                        ? SizedBox(
                            width: width,
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: width,
                                  margin: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: TextField(
                                    controller: barcaMotoreNome,
                                    decoration: const InputDecoration(
                                      hintText: "Nome Barca",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  height: 50,
                                  width: width,
                                  margin: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: TextField(
                                    controller: barcaMotoreLunghezza,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
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
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: TextField(
                                    controller: barcaMotoreLarghezza,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
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
                                  margin: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: barcaMotoreNumeroMotori,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        barcaMotoreNumeroCavalli = [];
                                        barcaMotoreMarcaMotori = [];
                                        numeroMotori = barcaMotoreNumeroMotori
                                                .text.isEmpty
                                            ? 0
                                            : int.parse(
                                                barcaMotoreNumeroMotori.text);
                                        for (var i = 0; i < numeroMotori; i++) {
                                          barcaMotoreNumeroCavalli
                                              .add(TextEditingController());
                                          barcaMotoreMarcaMotori
                                              .add(TextEditingController());
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
                                  height: 60.0 * numeroMotori,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
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
                                              bottom: 10,
                                            ),
                                            child: DropdownMenu(
                                              controller:
                                                  barcaMotoreMarcaMotori[index],
                                              width: width / 2 - 15,
                                              hintText: "Marca motore",
                                              dropdownMenuEntries: const [
                                                DropdownMenuEntry(
                                                  value: "Honda",
                                                  label: "Honda",
                                                ),
                                                DropdownMenuEntry(
                                                  value: "Suzuki",
                                                  label: "Suzuki",
                                                ),
                                                DropdownMenuEntry(
                                                  value: "Yamaha",
                                                  label: "Yamaha",
                                                ),
                                                DropdownMenuEntry(
                                                  value: "Tohatsu",
                                                  label: "Yohatsu",
                                                ),
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
                                              controller:
                                                  barcaMotoreNumeroCavalli[
                                                      index],
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
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
                                const SizedBox(height: 5),
                                GestureDetector(
                                  onTap: () {
                                    pickImageDialog();
                                  },
                                  child: Container(
                                    height: 200,
                                    width: width,
                                    margin: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.add_a_photo_rounded,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          )
                        : SizedBox(
                            width: width,
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: width,
                                  margin: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: TextField(
                                    controller: barcaVelaNome,
                                    decoration: const InputDecoration(
                                      hintText: "Nome Barca",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  height: 50,
                                  width: width,
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: TextField(
                                    controller: barcaVelaLunghezza,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
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
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: TextField(
                                    controller: barcaVelaLarghezza,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
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
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: TextField(
                                    controller: barcaVelaAltezza,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: const InputDecoration(
                                      hintText: "Altezza Barca",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          );
              },
            ),
          ),
          Container(
            height: 80,
            width: width,
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: const BoxDecoration(
              color: arancioneBoa,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: GestureDetector(
              onTap: () {
                addBarca();
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      setState(() {
        this.image = File(image.path);
        print(this.image);
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void pickImageDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    GestureDetector(
                      onTap: () {
                        pickImage(ImageSource.gallery);
                      },
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.photo),
                            SizedBox(width: 30),
                            Text("Galleria"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        pickImage(ImageSource.camera);
                      },
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.camera_alt),
                            SizedBox(width: 30),
                            Text("Camera"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: -40,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add_a_photo),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void addBarca() async {
    if (radioButtonValue == TipoBarca._null) {
      customDialog(
        context,
        "Nessun tipo selezionato",
        "Selezionane uno e riprova",
      );
      return;
    }
    if ((barcaMotoreLarghezza.text.isEmpty ||
            barcaMotoreLunghezza.text.isEmpty ||
            barcaMotoreNumeroMotori.text.isEmpty) &&
        radioButtonValue == TipoBarca.motore) {
      customDialog(context, "Errore", "Inserire i valori in tutti i campi");
      return;
    }
    if ((barcaVelaLarghezza.text.isEmpty ||
            barcaVelaLunghezza.text.isEmpty ||
            barcaVelaAltezza.text.isEmpty) &&
        radioButtonValue == TipoBarca.vela) {
      customDialog(context, "Errore", "Inserire i valori in tutti i campi");
      return;
    }
    bool isMotor = radioButtonValue == TipoBarca.motore ? true : false;
    if (radioButtonValue == TipoBarca.motore) {
      double larghezza = double.parse(barcaMotoreLarghezza.text);
      double lunghezza = double.parse(barcaMotoreLunghezza.text);
      String nome = barcaMotoreNome.text;
      List<Map<String, dynamic>> motori = [];
      for (var i = 0; i < int.parse(barcaMotoreNumeroMotori.text); i++) {
        motori.add({
          "marca": barcaMotoreMarcaMotori[i].text,
          "cavalli": int.parse(barcaMotoreNumeroCavalli[i].text),
        });
      }
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      await http.post(
        Uri.parse("http://192.168.1.100:1337/api/barche"),
        headers: headers,
        body: jsonEncode(
          {
            "data": {
              "nome_barca": nome,
              "larghezza": larghezza,
              "lunghezza": lunghezza,
              "UID": FirebaseAuth.instance.currentUser?.uid,
              "isMotor": isMotor,
              "image": {
                "data": null,
              },
              "Motore": motori,
              "Vela": null,
            }
          },
        ),
      );
    }

    if (radioButtonValue == TipoBarca.vela) {
      double larghezza = double.parse(barcaVelaLarghezza.text);
      double lunghezza = double.parse(barcaVelaLunghezza.text);
      double altezza = double.parse(barcaVelaAltezza.text);
      String nome = barcaVelaNome.text;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      await http.post(
        Uri.parse("http://192.168.1.100:1337/api/barche"),
        headers: headers,
        body: jsonEncode(
          {
            "data": {
              "larghezza": larghezza,
              "lunghezza": lunghezza,
              "nome_barca": nome,
              "UID": FirebaseAuth.instance.currentUser?.uid,
              "isMotor": isMotor,
              "image": {
                "data": null,
              },
              "Motore": [],
              "Vela": {
                "altezza": altezza,
              },
            }
          },
        ),
      );
    }
  }
}
