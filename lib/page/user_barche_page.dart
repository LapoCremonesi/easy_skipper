import 'dart:convert';
import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/barca.dart';
import 'package:easy_skipper/widget/custom_barca_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserBarche extends StatefulWidget {
  const UserBarche({super.key});

  @override
  State<UserBarche> createState() => _UserBarcheState();
}

class _UserBarcheState extends State<UserBarche> {
  List<Barche> barche = [];
  @override
  void initState() {
    super.initState();
    getBarche();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBar = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150,
            width: width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: verdeAcquaMarina,
            ),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, top: statusBar + 10),
                  decoration: const BoxDecoration(
                    color: bluOceanoProfondo,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Le mie Barche',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: statusBar + 20),
          SizedBox(
            height: height - statusBar - 170,
            width: width,
            child: SizedBox(
              height: barche.length * 105.0,
              child: ListView.builder(
                itemCount: barche.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CustomBarcaDisplay(barcaInfo: barche[index]),
                      const SizedBox(height: 5),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getBarche() async {
    barche = [];
    final response = await http.get(
      Uri.parse("$api/api/get_barca?UID=${FirebaseAuth.instance.currentUser?.uid}"),
      headers: headers,
    );
    final json = jsonDecode(response.body);

    for (int i = 0; i < json.length; i++) {
      setState(() {
        barche.add(Barche.fromJson(json[i]));
      });
    }
  }
}
