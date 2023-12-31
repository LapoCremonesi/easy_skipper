import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/firebase/firebase_auth_services.dart';
import 'package:easy_skipper/page/login_page.dart';
import 'package:easy_skipper/page/signUp/choose_role_page_sign_up.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:easy_skipper/widget/custom_text_field.dart';
import 'package:easy_skipper/object/custom_user.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
    required this.userProfile,
  });

  final CustomProfile userProfile;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isPasswordCorrect = false;
  TextEditingController usernameFieldController = TextEditingController();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController confirmPasswordFieldController =
      TextEditingController();

  FirebaseAuthService auth = FirebaseAuthService();

  FocusNode passwordFocusNode = FocusNode();
  bool showPasswordRequierement = false;

  @override
  void initState() {
    super.initState();
    passwordFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    passwordFocusNode.removeListener(_onFocusChange);
    passwordFocusNode.dispose();

    usernameFieldController.dispose();
    emailFieldController.dispose();
    passwordFieldController.dispose();
    confirmPasswordFieldController.dispose();
  }

  void _onFocusChange() {
    setState(() {
      showPasswordRequierement = !showPasswordRequierement;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 150,
        centerTitle: true,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_login.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 10,
              margin: EdgeInsets.only(top: statusBarHeight + 150),
            ),
            CustomTextField(
              height: 50,
              width: width,
              labelText: "UserName",
              textInputType: TextInputType.name,
              leftMargin: 20,
              rightMargin: 10,
              controller: usernameFieldController,
              textFieldIcon: const Icon(Icons.person_rounded),
            ),
            const SizedBox(height: 15),
            CustomTextField(
              height: 50,
              width: width,
              labelText: "Email",
              textInputType: TextInputType.emailAddress,
              controller: emailFieldController,
              hintText: "example@domain.com",
              leftMargin: 20,
              rightMargin: 10,
              textFieldIcon: const Icon(Icons.email),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Container(
                  height: 50,
                  width: width - 80,
                  margin: const EdgeInsets.only(left: 20),
                  child: TextField(
                    focusNode: passwordFocusNode,
                    obscureText: !isPasswordVisible,
                    controller: passwordFieldController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.lock),
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
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ),
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
            const SizedBox(height: 5),
            showPasswordRequierement
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: width - 70,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: Color.fromARGB(128, 255, 255, 255),
                      ),
                      child: FlutterPwValidator(
                        defaultColor: Colors.black,
                        controller: passwordFieldController,
                        width: width - 70,
                        height: 120,
                        minLength: 8,
                        uppercaseCharCount: 1,
                        specialCharCount: 1,
                        onSuccess: () {
                          setState(() {
                            isPasswordCorrect = true;
                          });
                        },
                        onFail: () {
                          setState(() {
                            isPasswordCorrect = false;
                          });
                        },
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(height: 15),
            Row(
              children: [
                CustomTextField(
                  height: 50,
                  width: width - 80,
                  labelText: "Confirm Password",
                  textInputType: TextInputType.visiblePassword,
                  controller: confirmPasswordFieldController,
                  obscureText: !isConfirmPasswordVisible,
                  textFieldIcon: const Icon(Icons.lock),
                  leftMargin: 20,
                ),
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                    icon: isConfirmPasswordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                )
              ],
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: width,
                    decoration: BoxDecoration(
                      color: arancioneBoa,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 15,
                    ),
                    child: TextButton(
                      onPressed: () {
                        signUp();
                      },
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
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogInPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Already have an account: Log In",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void signUp() async {
    String email = emailFieldController.text;
    String password = passwordFieldController.text;
    String confirmPassword = confirmPasswordFieldController.text;
    String username = usernameFieldController.text;

    if (!EmailValidator.validate(email)) {
      customDialog(
        context,
        "The email you added was incorrect or doesn't exist",
        "Try correct it or change it",
      );
      return;
    }

    if (username.isEmpty) {
      customDialog(
        context,
        "You have inserted no username",
        "Enter a username e retry",
      );
    }

    if (password != confirmPassword ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        !isPasswordCorrect) {
      customDialog(
        context,
        "You have inserted no password or it was wrong",
        "Try correct it or change it",
      );
      return;
    }

    CustomUser user = CustomUser(
      password: password,
      email: email,
    );

    widget.userProfile.username = username;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseRoleSignUpPage(
          user: user,
          userProfile: widget.userProfile,
        ),
      ),
    );
  }
}
