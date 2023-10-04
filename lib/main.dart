import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/page/signup_page.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_skipper/page/home_page.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemStatusBarContrastEnforced: true,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCGUJKx0BUuQ5inaWYyxheTJdpolpsYZpQ",
        appId: "1:665139195164:web:a76a9682b15b2c1e08ded9",
        messagingSenderId: "665139195164",
        projectId: "easyskipper-11c48",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  bool isUserRegistered = FirebaseAuth.instance.currentUser != null;
  CustomProfile userProfile = CustomProfile(
    username: "",
    UID: "",
    id: 0,
    isAgency: false,
    isListView: true,
  );

  if (isUserRegistered) {
    final response = await http.get(
      Uri.parse(
        '$api/profiles?filters[UID][\$eq]=${FirebaseAuth.instance.currentUser?.uid}',
      ),
    );
    userProfile = CustomProfile.fromJson(jsonDecode(response.body));
  }

  runApp(MyApp(
    isUserRegistered: isUserRegistered,
    userProfile: userProfile,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.isUserRegistered,
    required this.userProfile,
  });

  final bool isUserRegistered;
  final CustomProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Noto'),
      debugShowCheckedModeBanner: false,
      home: isUserRegistered
          ? HomePage(userProfile: userProfile)
          : SignUpPage(userProfile: userProfile),
    );
  }
}
