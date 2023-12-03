import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/firebase/firebase_auth_services.dart';
import 'package:easy_skipper/main.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:easy_skipper/page/aggiungi_barca.dart';
import 'package:easy_skipper/page/prenotazioni_page.dart';
import 'package:easy_skipper/page/user_barche_page.dart';
import 'package:flutter/material.dart';

class UserDialog extends StatefulWidget {
  const UserDialog({
    super.key,
    required this.userProfile,
  });

  final CustomProfile userProfile;

  @override
  State<UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 580,
        width: width - 20,
        child: Column(
          children: [
            Container(
              width: width - 20,
              height: 250,
              decoration: const BoxDecoration(
                color: bluOceanoProfondo,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 205,
                    right: 0,
                    child: Container(
                      height: 50,
                      width: width - 20,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width - 20,
              height: 330,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const UserBarche();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 70,
                      width: width - 20,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                        color: blueCieloChiaro,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Row(
                        children: [
                          Spacer(flex: 2),
                          Text("Le mie Barche", style: TextStyle(fontSize: 20)),
                          SizedBox(width: 10),
                          Icon(Icons.directions_boat_filled_rounded, size: 30),
                          Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const AggiungiBarca();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 70,
                      width: width - 20,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                        color: blueCieloChiaro,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Row(
                        children: [
                          Spacer(flex: 2),
                          Text("Aggiungi Barca", style: TextStyle(fontSize: 20)),
                          SizedBox(width: 10),
                          Icon(Icons.add, size: 30),
                          Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrenotazioniPage(),
                        ),
                      );
                    },
                    child: Container(
                      height: 70,
                      width: width - 20,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                        color: blueCieloChiaro,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Row(
                        children: [
                          Spacer(flex: 2),
                          Text("Prenotazioni", style: TextStyle(fontSize: 20)),
                          SizedBox(width: 10),
                          Icon(Icons.calendar_month_rounded, size: 30),
                          Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      FirebaseAuthService().signOut();
                      RestartMain.restartApp(context);
                    },
                    child: Container(
                      height: 70,
                      width: width - 20,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                        color: blueCieloChiaro,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Row(
                        children: [
                          Spacer(flex: 2),
                          Text("Log Out", style: TextStyle(fontSize: 20)),
                          SizedBox(width: 10),
                          Icon(Icons.logout_outlined, size: 30),
                          Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
