// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/custom_agency.dart';
import 'package:easy_skipper/object/service.dart';
import 'package:easy_skipper/page/agency_dialog.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:easy_skipper/page/user_dialog.dart';
import 'package:easy_skipper/widget/homepage_box_view.dart';
import 'package:easy_skipper/widget/homepage_tile_view.dart';
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
  late bool isListView = widget.userProfile.isListView;
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
                          final response = await http.get(
                            Uri.parse(
                              "$api/api/agencies?filters[Servizi][servizio][\$contains]=${servizi[index]}&populate=*",
                            ),
                          );

                          agenzie = [];
                          final json = jsonDecode(response.body)["data"];

                          for (int i = 0; i < json.length && i < 10; i++) {
                            setState(() {
                              agenzie.add(
                                CustomAgency.fromJson(
                                  json[i],
                                  false,
                                ),
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
                    final response = await http.get(
                      Uri.parse("$api/api/agencies?populate=*"),
                    );

                    agenzie = [];
                    final json = jsonDecode(response.body)["data"];

                    for (int i = 0; i < json.length && i < 10; i++) {
                      setState(() {
                        agenzie.add(
                          CustomAgency.fromJson(
                            json[i],
                            false,
                          ),
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
                height: 300 *
                    ((height - 100 - 60 - 20 - 30 - 50 - 10 - statusBarHeight) /
                        300),
                child: ListView.builder(
                  itemCount: isListView
                      ? agenzie.length
                      : agenzie.length % 2 == 0
                          ? agenzie.length ~/ 2
                          : (agenzie.length + 1) ~/ 2,
                  itemBuilder: (context, index) {
                    j += 2;

                    if (isListView) {
                      return HomePageTileView(
                        agency: agenzie[index],
                        userProfile: widget.userProfile,
                      );
                    } else {
                      if (agenzie.length % 2 == 0) {
                        return Row(
                          children: [
                            HomePageBoxView(
                              agency: agenzie[j - 2],
                              userProfile: widget.userProfile,
                            ),
                            HomePageBoxView(
                              agency: agenzie[j - 1],
                              userProfile: widget.userProfile,
                            ),
                          ],
                        );
                      } else {
                        if (j - 1 == agenzie.length) {
                          return Row(
                            children: [
                              HomePageBoxView(
                                agency: agenzie[j - 2],
                                userProfile: widget.userProfile,
                              ),
                              const SizedBox(),
                            ],
                          );
                        }
                        return Row(
                          children: [
                            HomePageBoxView(
                              agency: agenzie[j - 2],
                              userProfile: widget.userProfile,
                            ),
                            HomePageBoxView(
                              agency: agenzie[j - 1],
                              userProfile: widget.userProfile,
                            ),
                          ],
                        );
                      }
                    }
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
    final response = await http.get(
      Uri.parse(
        "$api/api/agencies?filters[UID][\$eq]=${FirebaseAuth.instance.currentUser?.uid}&populate=*",
      ),
    );
    setState(() {
      widget.agency = CustomAgency.fromJson(
        jsonDecode(response.body)["data"][0],
        false,
      );
    });
  }

  Future getData() async {
    final response = await http.get(
      Uri.parse("$api/api/agencies?populate=*"),
    );

    final json = jsonDecode(response.body)["data"];

    for (int i = 0; i < json.length && i < 10; i++) {
      setState(() {
        agenzie.add(
          CustomAgency.fromJson(
            json[i],
            false,
          ),
        );
      });
    }
  }
}
