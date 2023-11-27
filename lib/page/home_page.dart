// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/custom_agency.dart';
import 'package:easy_skipper/object/service.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:easy_skipper/widget/agency_dialog.dart';
import 'package:easy_skipper/widget/homepage_tile_view.dart';
import 'package:easy_skipper/widget/user_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required this.userProfile,
    required this.agency,
  });

  final CustomProfile userProfile;
  late CustomAgency agency;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CustomAgency> agenzie = [];
  List<String> servizi = [
    "manutenzione",
    "trasporto",
    "pulizia",
    "gestione",
  ];
  late int j;

  @override
  void initState() {
    super.initState();
    getData();
    widget.userProfile.isAgency ? getAgency() : null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    j = 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: verdeAcquaMarina,
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text("Easy Skipper"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return widget.userProfile.isAgency
                      ? AgencyDialog(
                          userProfile: widget.userProfile,
                          agency: widget.agency,
                        )
                      : UserDialog(userProfile: widget.userProfile);
                },
              );
            },
            child: CircleAvatar(
              backgroundColor: blueCobalto,
              child: widget.userProfile.isAgency
                  ? const Center(
                      child: Icon(
                        Icons.business_rounded,
                        color: Colors.white,
                      ),
                    )
                  : const Center(
                      child: Icon(
                        Icons.person_rounded,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              height: 60,
              width: width,
              margin: const EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.search),
                  ),
                  border: const OutlineInputBorder(),
                  hintText: "Search",
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: width - 50 - (width - 250) / 10,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: servizi.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          final response = await http.get(Uri.parse("$api/api/agencies?filters[Servizi][servizio][\$contains]=${servizi[index]}&populate=*"));

                          agenzie = [];
                          final json = jsonDecode(response.body)["data"];

                          for (int i = 0; i < json.length && i < 10; i++) {
                            setState(() {
                              agenzie.add(
                                CustomAgency.fromJson(json[i]),
                              );
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: (width - 250) / 10,
                            right: (width - 250) / 10,
                          ),
                          child: Service(
                            service: servizi[index],
                            height: 50,
                            width: 50,
                            size: 30,
                            padding: 10,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final response = await http.get(Uri.parse("$api/api/agencies?populate=*"));

                    agenzie = [];
                    final json = jsonDecode(response.body)["data"];

                    for (int i = 0; i < json.length && i < 10; i++) {
                      setState(() {
                        agenzie.add(
                          CustomAgency.fromJson(json[i]),
                        );
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(right: (width - 250) / 10),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              child: SizedBox(
                height: 300 * ((height - 100 - 60 - 20 - 30 - 50 - 10 - statusBarHeight) / 300),
                child: ListView.builder(
                  itemCount: agenzie.length,
                  itemBuilder: (context, index) {
                    return HomePageTileView(
                      agency: agenzie[index],
                      userProfile: widget.userProfile,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getAgency() async {
    final response = await http.get(Uri.parse("$api/api/get_agency?UID=${FirebaseAuth.instance.currentUser?.uid}"));
    setState(() {
      widget.agency = CustomAgency.fromJson(jsonDecode(response.body)["data"][0]);
    });
  }

  Future getData() async {
    final response = await http.post(
      Uri.parse("$api/api/get_agency"),
      body: {
        "UID": FirebaseAuth.instance.currentUser?.uid,
      },
    );

    final json = jsonDecode(response.body)["data"];

    for (int i = 0; i < json.length && i < 10; i++) {
      setState(() {
        agenzie.add(
          CustomAgency.fromJson(json[i]),
        );
      });
    }
  }
}
