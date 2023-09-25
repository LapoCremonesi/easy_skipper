import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/page/signUp/signup_azienda.dart';
import 'package:easy_skipper/page/signUp/signup_user.dart';
import 'package:easy_skipper/page/signup_page.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:easy_skipper/object/custom_user.dart';
import 'package:flutter/material.dart';

class ChooseRoleSignUpPage extends StatefulWidget {
  const ChooseRoleSignUpPage({
    super.key,
    required this.user,
    required this.userProfile,
  });

  final CustomUser user;
  final CustomProfile userProfile;

  @override
  State<ChooseRoleSignUpPage> createState() => _ChooseRoleSignUpPageState();
}

class _ChooseRoleSignUpPageState extends State<ChooseRoleSignUpPage> {
  bool isUserCardSelected = false;
  bool isAgencyCardSelected = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              blueCobalto,
              blueCieloChiaro,
            ],
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              "Seleziona il ruolo per l'account",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isUserCardSelected = true;
                      isAgencyCardSelected = false;
                    });
                  },
                  child: Container(
                    height: 300,
                    width: width / 2 - 15,
                    margin: const EdgeInsets.only(left: 10, right: 5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      border: isUserCardSelected ? Border.all() : null,
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_rounded,
                          size: 60,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "User",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isUserCardSelected = false;
                      isAgencyCardSelected = true;
                    });
                  },
                  child: Container(
                    height: 300,
                    width: width / 2 - 15,
                    margin: const EdgeInsets.only(left: 5, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      border: isAgencyCardSelected ? Border.all() : null,
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.business_rounded,
                          size: 60,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Azienda",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
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
                    height: 60,
                    width: width / 2 - 15,
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 5,
                      bottom: 10,
                    ),
                    decoration: const BoxDecoration(
                      color: arancioneBoa,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back_rounded),
                        SizedBox(width: 10),
                        Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (isUserCardSelected) {
                      widget.userProfile.isAgency = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserSignUp(
                            userProfile: widget.userProfile,
                            user: widget.user,
                          ),
                        ),
                      );
                    }
                    if (isAgencyCardSelected) {
                      widget.userProfile.isAgency = true;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AziendaSignUp(
                            profile: widget.userProfile,
                            user: widget.user,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 60,
                    width: width / 2 - 15,
                    margin: const EdgeInsets.only(
                      left: 5,
                      right: 10,
                      bottom: 10,
                    ),
                    decoration: const BoxDecoration(
                      color: arancioneBoa,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward_rounded),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
