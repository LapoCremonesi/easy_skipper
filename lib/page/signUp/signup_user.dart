import 'dart:convert';
import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/firebase/firebase_auth_services.dart';
import 'package:easy_skipper/object/custom_agency.dart';
import 'package:easy_skipper/page/home_page.dart';
import 'package:easy_skipper/page/signup_page.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:easy_skipper/object/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class UserSignUp extends StatefulWidget {
  const UserSignUp({
    super.key,
    required this.user,
    required this.userProfile,
  });

  final CustomUser user;
  final CustomProfile userProfile;

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

enum TipoBarca { vela, motore, _null }

class _UserSignUpState extends State<UserSignUp> {
  int numeroMotori = 0;
  TipoBarca radioButtonValue = TipoBarca._null;

  TextEditingController barcaNome = TextEditingController();

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
      resizeToAvoidBottomInset: false,
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
            height: height - statusBarHeight - 10 - 50 - 56 - 112 - 10,
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
                                    controller: barcaNome,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: "Nome della barca",
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
                                    controller: barcaNome,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: "Nome della barca",
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
          SizedBox(
            height: 50,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(
                          userProfile: widget.userProfile,
                        ),
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
          const SizedBox(height: 10),
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

    if (barcaNome.text.isEmpty) {
      customDialog(context, "Errore", "Inserire un nome per la barca");
      return;
    }

    User? user = await FirebaseAuthService().signUpWithEmailAndPassword(
      widget.user.email,
      widget.user.password,
    );

    if (user != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      await http.post(
        Uri.parse("$api/api/profiles"),
        headers: headers,
        body: jsonEncode(
          {
            "data": {
              "username": widget.userProfile.username,
              "UID": user.uid,
              "isAgency": widget.userProfile.isAgency,
              "isListView": widget.userProfile.isListView,
            }
          },
        ),
      );
      bool isMotor = radioButtonValue == TipoBarca.motore ? true : false;
      String nome = barcaNome.text;
      if (radioButtonValue == TipoBarca.motore) {
        double larghezza = double.parse(barcaMotoreLarghezza.text);
        double lunghezza = double.parse(barcaMotoreLunghezza.text);
        List<Map<String, dynamic>> motori = [];
        for (var i = 0; i < int.parse(barcaMotoreNumeroMotori.text); i++) {
          motori.add({
            "id": i + 1,
            "marca": barcaMotoreMarcaMotori[i].text,
            "cavalli": int.parse(barcaMotoreNumeroCavalli[i].text),
          });
        }
        await http.post(
          Uri.parse("$api/api/barche"),
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
        navigate(
          CustomAgency(
            indirizzo: '',
            nome: '',
            telefono: '',
            UID: '',
            mediumImage: '',
            thumbnailImage: '',
            servizi: [],
          ),
          widget.userProfile,
        );
      }
      if (radioButtonValue == TipoBarca.vela) {
        double larghezza = double.parse(barcaVelaLarghezza.text);
        double lunghezza = double.parse(barcaVelaLunghezza.text);
        double altezza = double.parse(barcaVelaAltezza.text);
        await http.post(
          Uri.parse("$api/api/barche"),
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
                "Motore": [],
                "Vela": {
                  "altezza": altezza,
                },
              }
            },
          ),
        );
        navigate(
          CustomAgency(
            indirizzo: '',
            nome: '',
            telefono: '',
            UID: '',
            mediumImage: '',
            thumbnailImage: '',
            servizi: [],
          ),
          widget.userProfile,
        );
      }
    } else {}
  }

  void navigate(CustomAgency agency, CustomProfile userProfile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          userProfile: widget.userProfile,
          agency: agency,
        ),
      ),
    );
  }
}
