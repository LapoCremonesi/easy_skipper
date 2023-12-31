import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/custom_agency.dart';
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
  CustomProfile userProfile = CustomProfile(username: "", UID: "", isAgency: false, prenotazioni: []);
  CustomAgency agency = CustomAgency(indirizzo: '', nome: '', telefono: '', UID: '', image: '', servizi: [], prenotazioni: []);

  if (isUserRegistered && isConnected) {
    final userProfileResponse = await http.get(
      Uri.parse('$api/api/get_profile?UID=${FirebaseAuth.instance.currentUser?.uid}'),
      headers: headers,
    );
    userProfile = CustomProfile.fromJson(jsonDecode(userProfileResponse.body));

    if (userProfile.isAgency) {
      final agencyResponse = await http.get(
        Uri.parse("$api/api/get_agency?UID=${FirebaseAuth.instance.currentUser?.uid}"),
        headers: headers,
      );
      agency = CustomAgency.fromJson(jsonDecode(agencyResponse.body));
    }
  }

  runApp(RestartMain(
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

class RestartMain extends StatefulWidget {
  const RestartMain({super.key, required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartMainState>()?.restartApp();
  }

  @override
  // ignore: library_private_types_in_public_api
  _RestartMainState createState() => _RestartMainState();
}

class _RestartMainState extends State<RestartMain> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
