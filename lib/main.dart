import 'package:easy_skipper/widget/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_skipper/page/login_page.dart';
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

  if (isUserRegistered) {
    final response = await http.get(
      Uri.parse(
        'http://192.168.1.100:1337/api/profiles?filters[UID][\$eq]=${FirebaseAuth.instance.currentUser?.uid}',
      ),
    );
  }

  runApp(MyApp(isUserRegistered: isUserRegistered));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.isUserRegistered,
  });

  final bool isUserRegistered;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isUserRegistered ? HomePage(user: user) : const LogInPage(),
    );
  }
}
