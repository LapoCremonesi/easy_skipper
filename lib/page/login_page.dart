import 'package:easy_skipper/firebase/firebase_auth_services.dart';
import 'package:easy_skipper/page/home_page.dart';
import 'package:easy_skipper/page/signup_page.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_skipper/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();
  FirebaseAuthService auth = FirebaseAuthService();

  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_login.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 100,
                bottom: 50,
              ),
              child: const Text(
                "Log In",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: 50,
              width: width,
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: TextField(
                controller: emailFieldController,
                keyboardType: TextInputType.emailAddress,
                onSubmitted: (value) {},
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: "example@domain.com",
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  iconColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Container(
                  height: 50,
                  width: width - 70,
                  margin: const EdgeInsets.only(left: 10),
                  child: TextField(
                    obscureText: !isPasswordVisible,
                    controller: passwordFieldController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {},
                    decoration: const InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.black),
                      icon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      iconColor: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.white,
                    ),
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    icon: isPasswordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                )
              ],
            ),
            const Spacer(
              flex: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/google_logo.png",
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/apple_logo.png",
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/facebook_logo.png",
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(
                      userProfile: CustomProfile(
                        username: "",
                        UID: "",
                        id: 0,
                        isAgency: false,
                        isListView: true,
                      ),
                    ),
                  ),
                );
              },
              child: const Text(
                "Don't have an account: Sign Up",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Container(
              height: 50,
              width: width,
              margin: const EdgeInsets.only(
                bottom: 10,
                left: 15,
                right: 15,
              ),
              decoration: const BoxDecoration(
                color: arancioneBoa,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  signIn();
                },
                child: const Center(
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void signIn() async {
    String email = emailFieldController.text;
    String password = passwordFieldController.text;

    User? user = await auth.signInWithEmailAndPassword(email, password);

    final response = await http.get(
      Uri.parse(
        '$api/profiles?filters[UID][\$eq]=${FirebaseAuth.instance.currentUser?.uid}',
      ),
    );
    CustomProfile userProfile = CustomProfile.fromJson(
      jsonDecode(response.body),
    );

    if (user != null) {
      print("Successfully Logged In");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            userProfile: userProfile,
            api: "",
          ),
        ),
      );
    } else {
      print("some error occured");
    }
  }
}
