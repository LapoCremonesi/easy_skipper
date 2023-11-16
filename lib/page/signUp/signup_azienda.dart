import 'dart:convert';
import 'package:easy_skipper/firebase/firebase_auth_services.dart';
import 'package:easy_skipper/object/custom_agency.dart';
import 'package:easy_skipper/object/custom_user.dart';
import 'package:http/http.dart' as http;
import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:easy_skipper/page/home_page.dart';
import 'package:easy_skipper/page/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AziendaSignUp extends StatefulWidget {
  const AziendaSignUp({
    super.key,
    required this.user,
    required this.profile,
  });

  final CustomUser user;
  final CustomProfile profile;

  @override
  State<AziendaSignUp> createState() => _AziendaSignUpState();
}

class _AziendaSignUpState extends State<AziendaSignUp> {
  final TextEditingController nomeAzienda = TextEditingController();
  final TextEditingController indirizzoAzienda = TextEditingController();
  final TextEditingController telefonoAzienda = TextEditingController();
  final TextEditingController codiceFiscaleAzienda = TextEditingController();
  final List<Map<String, String>> servizi = [];

  bool isManutenzioneSelected = false;
  bool isTrasportoSelected = false;
  bool isPuliziaSelected = false;
  bool isGestioneSelected = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: nomeAzienda,
                decoration: const InputDecoration(
                  hintText: "Nome Azienda",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: indirizzoAzienda,
                decoration: const InputDecoration(
                  hintText: "Indirizzo",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: telefonoAzienda,
                decoration: const InputDecoration(
                  hintText: "Telefono",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: codiceFiscaleAzienda,
                decoration: const InputDecoration(
                  hintText: "Codice Fiscale",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              "Seleziona i servizi",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isManutenzioneSelected = !isManutenzioneSelected;
                      if (isManutenzioneSelected) {
                        servizi.add(
                          {
                            "servizio": "manutenzione",
                          },
                        );
                      } else {
                        servizi.remove(
                          {
                            "servizio": "manutenzione",
                          },
                        );
                      }
                    });
                  },
                  child: Container(
                    height: 40,
                    width: width / 2 - 15,
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                      color: isManutenzioneSelected ? blueCobalto : blueCieloChiaro,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Icon(isManutenzioneSelected ? Ionicons.checkmark_outline : Icons.add),
                        const SizedBox(width: 5),
                        const Text("Manutenzione"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isTrasportoSelected = !isTrasportoSelected;
                      if (isTrasportoSelected) {
                        servizi.add(
                          {
                            "servizio": "trasporto",
                          },
                        );
                      } else {
                        servizi.remove(
                          {
                            "servizio": "trasporto",
                          },
                        );
                      }
                    });
                  },
                  child: Container(
                    height: 40,
                    width: width / 2 - 15,
                    margin: const EdgeInsets.only(
                      left: 5,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isTrasportoSelected ? blueCobalto : blueCieloChiaro,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Icon(isTrasportoSelected ? Ionicons.checkmark_outline : Icons.add),
                        const SizedBox(width: 5),
                        const Text("Trasporto"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPuliziaSelected = !isPuliziaSelected;
                      if (isPuliziaSelected) {
                        servizi.add(
                          {
                            "servizio": "pulizia",
                          },
                        );
                      } else {
                        servizi.remove(
                          {
                            "servizio": "pulizia",
                          },
                        );
                      }
                    });
                  },
                  child: Container(
                    height: 40,
                    width: width / 2 - 15,
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                      color: isPuliziaSelected ? blueCobalto : blueCieloChiaro,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Icon(isPuliziaSelected ? Ionicons.checkmark_outline : Icons.add),
                        const SizedBox(width: 5),
                        const Text("Pulizia"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isGestioneSelected = !isGestioneSelected;
                      if (isGestioneSelected) {
                        servizi.add(
                          {
                            "servizio": "gestione",
                          },
                        );
                      } else {
                        servizi.remove(
                          {
                            "servizio": "gestione",
                          },
                        );
                      }
                    });
                  },
                  child: Container(
                    height: 40,
                    width: width / 2 - 15,
                    margin: const EdgeInsets.only(
                      left: 5,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isGestioneSelected ? blueCobalto : blueCieloChiaro,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Icon(isGestioneSelected ? Ionicons.checkmark_outline : Icons.add),
                        const SizedBox(width: 5),
                        const Text("Gestione"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
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
                            userProfile: widget.profile,
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
      ),
    );
  }

  void signUp() async {
    if (nomeAzienda.text.isEmpty || indirizzoAzienda.text.isEmpty || telefonoAzienda.text.isEmpty || codiceFiscaleAzienda.text.isEmpty || servizi.isEmpty) {
      customDialog(context, "Errore", "Inserire i valori in tutti i campi");
      return;
    }

    User? user = await FirebaseAuthService().signUpWithEmailAndPassword(
      widget.user.email,
      widget.user.password,
    );

    if (user != null) {
      Map<String, String> headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};
      await http.post(
        Uri.parse("$api/api/profiles"),
        headers: headers,
        body: jsonEncode(
          {
            "data": {
              "username": widget.profile.username,
              "UID": user.uid,
              "isAgency": widget.profile.isAgency,
            }
          },
        ),
      );
      await http.post(
        Uri.parse("$api/api/agencies"),
        headers: headers,
        body: jsonEncode(
          {
            "data": {
              "indirizzo": indirizzoAzienda.text,
              "nome": nomeAzienda.text,
              "telefono": telefonoAzienda.text,
              "codice_fiscale": codiceFiscaleAzienda.text,
              "UID": FirebaseAuth.instance.currentUser?.uid,
              "Servizi": servizi,
            },
          },
        ),
      );

      final agencyResponse = await http.get(Uri.parse("$api/api/agencies?filters[UID][\$eq]=${FirebaseAuth.instance.currentUser?.uid}&populate=*"));
      CustomAgency agency = CustomAgency.fromJson(
        jsonDecode(agencyResponse.body),
        false,
      );

      navigate(agency, widget.profile);
    } else {}
  }

  void navigate(CustomAgency agency, CustomProfile userProfile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          userProfile: widget.profile,
          agency: agency,
        ),
      ),
    );
  }
}
