import 'package:easy_skipper/page/signUp/choose_role_page_sign_up.dart';
import 'package:easy_skipper/page/signUp/signup_user.dart';
import 'package:easy_skipper/widget/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_skipper/page/azienda_page.dart';
import 'package:easy_skipper/page/login_page.dart';
import 'package:easy_skipper/page/home_page.dart';
import 'package:easy_skipper/page/filter_page.dart';
import 'package:easy_skipper/page/user_page.dart';
import 'package:easy_skipper/page/signup_page.dart';
import 'package:flutter/services.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          FirebaseAuth.instance.currentUser != null ? HomePage() : LogInPage(),
    );
  }
}

//