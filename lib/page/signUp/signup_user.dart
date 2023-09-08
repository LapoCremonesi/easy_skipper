import 'dart:convert';

import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/firebase/firebase_auth_services.dart';
import 'package:easy_skipper/page/signup_page.dart';
import 'package:easy_skipper/widget/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class UserSignUp extends StatefulWidget {
  UserSignUp({super.key, required this.user});

  CustomUser user;

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

enum TipoBarca { vela, motore, _null }

class _UserSignUpState extends State<UserSignUp> {
  int numeroMotori = 0;
  TipoBarca radioButtonValue = TipoBarca._null;

  TextEditingController barcaMotoreLarghezza = TextEditingController();
  TextEditingController barcaMotoreLunghezza = TextEditingController();
  TextEditingController barcaMotoreNumeroMotori = TextEditingController();
  List<TextEditingController> barcaMotoreMarcaMotori = [];
  List<TextEditingController> barcaMotoreNumeroCavalli = [];

  TextEditingController barcaVelaLarghezza = TextEditingController();
  TextEditingController barcaVelaLunghezza = TextEditingController();
  TextEditingController barcaVelaAltezza = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Inserisci i dati per completare la registrazione",
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
            height: height - statusBarHeight - 10 - 50 - 56 - 112,
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
                                      left: 10, right: 10),
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
          SizedBox(
            height: 50,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: width / 2 - 15,
                    margin: const EdgeInsets.only(left: 10, right: 5),
                    decoration: BoxDecoration(
                      color: arancioneBoa,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back_rounded),
                        Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => signUp(),
                  child: Container(
                    height: 50,
                    width: width / 2 - 15,
                    margin: const EdgeInsets.only(left: 5, right: 10),
                    decoration: BoxDecoration(
                      color: arancioneBoa,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        Icon(Icons.arrow_forward_rounded),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void signUp() async {
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
    /*
    User? user = await FirebaseAuthService().signUpWithEmailAndPassword(
      widget.user.email,
      widget.user.password,
    );

    user != null
    */
    if (true) {
      bool isMotor = radioButtonValue == TipoBarca.motore ? true : false;
      if (radioButtonValue == TipoBarca.motore) {
        int larghezza = int.parse(barcaMotoreLarghezza.text);
        int lunghezza = int.parse(barcaMotoreLunghezza.text);
        //String UID = FirebaseAuth.instance.currentUser!.uid;
        List<Map<String, dynamic>> motori = [];
        for (var i = 0; i < int.parse(barcaMotoreNumeroMotori.text); i++) {
          motori.add({
            "id": i + 1,
            "marca": barcaMotoreMarcaMotori[i].text,
            "cavalli": int.parse(barcaMotoreNumeroCavalli[i].text),
          });
        }
        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        };
        var response = await http.post(
          Uri.parse("http://192.168.1.100:1337/api/barche"),
          headers: headers,
          body: jsonEncode(
            {
              "data": [
                {
                  "id": 3,
                  "attributes": {
                    "larghezza": larghezza,
                    "lunghezza": lunghezza,
                    "UID": "UID",
                    "isMotor": isMotor,
                    "image": {
                      "data": null,
                    },
                    "Motore": motori,
                    "Vela": null,
                  },
                }
              ]
            },
          ),
        );
        print(response.statusCode);
        print(response.body);
      }
    } else {
      print("Somthing went wrong");
    }
  }
}


/*
?filters[UID][$eq]=a1b2c3
command to search using UID value
*/