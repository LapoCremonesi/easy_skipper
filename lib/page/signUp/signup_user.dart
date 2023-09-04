import 'package:easy_skipper/widget/barca_motore.dart';
import 'package:easy_skipper/widget/barca_vela.dart';
import 'package:easy_skipper/widget/custom_user.dart';
import 'package:flutter/material.dart';

class UserSignUp extends StatefulWidget {
  UserSignUp({super.key, required this.user});

  CustomUser user;

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

enum TipoBarca { vela, motore, _null }

class _UserSignUpState extends State<UserSignUp> {
  int numerobarche = 0;
  TipoBarca radioButtonValue = TipoBarca._null;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, _) {
          return Column(
            children: [
              const Text(
                "Inserisci i dati per completare la registrazione",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: TipoBarca.motore,
                        groupValue: radioButtonValue,
                        onChanged: (value) {
                          setState(() {
                            radioButtonValue = value!;
                          });
                        },
                      ),
                      const Text("Motore"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: TipoBarca.vela,
                        groupValue: radioButtonValue,
                        onChanged: (value) {
                          setState(() {
                            radioButtonValue = value!;
                          });
                        },
                      ),
                      const Text("Vela"),
                    ],
                  ),
                ],
              ),
              radioButtonValue == TipoBarca._null
                  ? Container()
                  : radioButtonValue == TipoBarca.motore
                      ? BarcaMotore()
                      : BarcaVela(),
            ],
          );
        },
      ),
    );
  }
}
