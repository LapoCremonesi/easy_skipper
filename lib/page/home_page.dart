import 'dart:convert';
import 'package:easy_skipper/page/azienda_page.dart';
import 'package:easy_skipper/page/user_page.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:easy_skipper/widget/homepage_box_view.dart';
import 'package:easy_skipper/widget/homepage_tile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.userProfile,
  });

  final CustomProfile userProfile;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isListView = widget.userProfile.isListView;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text("HomePage"),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => widget.userProfile.isAgency
                      ? const AziendaPage()
                      : UserPage(userProfile: widget.userProfile),
                ),
              );
            },
            child: const CircleAvatar(
              backgroundColor: Colors.red,
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
                  suffixIcon: GestureDetector(
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
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isListView = true;
                    });
                    print(isListView);

                    await http.put(
                      Uri.parse(
                        "http://192.168.1.100:1337/api/profiles?filters[UID][\$eq]=${FirebaseAuth.instance.currentUser?.uid}",
                      ),
                      headers: {
                        "Authorization":
                            "Bearer 80d39bc5a56f4ee715b09a3a89653647181a687c63ac5dc498702678a6bcba71a732c01b6bbe62fb53f92b37f485db54518851962b05d853d364322c2b6a233b217e1feffd627ab14a94cd1cdc720ae113a32392705bf311a5eca7821bc833ed4cb29e1669ca7c31245efe246f19851170804a803dd1e621f6666ae96a596712"
                      },
                      body: jsonEncode(
                        {
                          "data": {
                            "isListView": isListView,
                          },
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: isListView ? Colors.red : Colors.grey,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.view_list_rounded,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isListView = false;
                    });
                    print(isListView);

                    await http.put(
                      Uri.parse(
                        "http://192.168.1.100:1337/api/profiles?filters[UID][\$eq]=${FirebaseAuth.instance.currentUser?.uid}",
                      ),
                      headers: {
                        "Authorization":
                            "Bearer 80d39bc5a56f4ee715b09a3a89653647181a687c63ac5dc498702678a6bcba71a732c01b6bbe62fb53f92b37f485db54518851962b05d853d364322c2b6a233b217e1feffd627ab14a94cd1cdc720ae113a32392705bf311a5eca7821bc833ed4cb29e1669ca7c31245efe246f19851170804a803dd1e621f6666ae96a596712"
                      },
                      body: jsonEncode(
                        {
                          "identifier": "database@easyskipper.it",
                          "password": "Easyskipper123!",
                          "data": {
                            "isListView": isListView,
                          },
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 50,
                    decoration: BoxDecoration(
                      color: !isListView ? Colors.red : Colors.grey,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    margin: const EdgeInsets.only(right: 10, bottom: 10),
                    child: const Center(
                      child: Icon(
                        Icons.grid_3x3_rounded,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: 300 *
                    ((height - 100 - 60 - 20 - 30 - 10 - statusBarHeight) /
                        300),
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return isListView
                        ? const HomePageTileView()
                        : const Row(
                            children: [
                              HomePageBoxView(),
                              HomePageBoxView(),
                            ],
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
}
