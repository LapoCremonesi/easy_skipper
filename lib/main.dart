import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/custom_agency.dart';
import 'package:easy_skipper/object/image.dart';
import 'package:easy_skipper/page/login_page.dart';
import 'package:easy_skipper/page/no_connection.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_skipper/page/home_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future main() async {
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

  final connection = await Connectivity().checkConnectivity();
  bool isConnected = connection == ConnectivityResult.none ? false : true;
  bool isUserRegistered = FirebaseAuth.instance.currentUser != null;
  CustomProfile userProfile = CustomProfile(
    username: "",
    UID: "",
    id: 0,
    isAgency: false,
  );
  CustomAgency agency = CustomAgency(
    indirizzo: '',
    nome: '',
    telefono: '',
    UID: '',
    image: CustomImage(),
    servizi: [],
  );

  if (isUserRegistered && isConnected) {
    final userProfileResponse = await http.get(Uri.parse('$api/api/profiles?filters[UID][\$eq]=${FirebaseAuth.instance.currentUser?.uid}'));
    userProfile = CustomProfile.fromJson(jsonDecode(userProfileResponse.body));

    final agencyResponse = await http.get(Uri.parse("$api/api/agencies?filters[UID][\$eq]=${FirebaseAuth.instance.currentUser?.uid}"));
    agency = CustomAgency.fromJson(
      jsonDecode(agencyResponse.body),
      !userProfile.isAgency,
    );
  }

  runApp(RestartWidget(
    child: MyApp(
      isUserRegistered: isUserRegistered,
      userProfile: userProfile,
      isConnected: isConnected,
      agency: agency,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.isUserRegistered,
    required this.userProfile,
    required this.isConnected,
    required this.agency,
  });

  final bool isUserRegistered;
  final bool isConnected;
  final CustomProfile userProfile;
  final CustomAgency agency;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Noto'),
      debugShowCheckedModeBanner: false,
      home: isConnected
          ? isUserRegistered
              ? HomePage(userProfile: userProfile, agency: agency)
              : const LogInPage()
          : const NoConnectionPage(),
    );
  }
}
